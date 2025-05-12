Return-Path: <stable+bounces-143362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82938AB3F7C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A419E4245
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFEC296FCA;
	Mon, 12 May 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZ+5DMZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CE1E2602;
	Mon, 12 May 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071745; cv=none; b=Rk2M6hpPjNui+HwYkhzx32r/DnWeL8aebwBGuuGVyeXnARo27+Z8hGlskCkBcxxr0+WJWJi1V2KmSD8sHBqn2QuHMJnm+rUWeJCp7aJtkoZWoblLGZoAhSNeTjBSHxwI+XQ0xm6WV9uz06wNVRKkrdN6KMNxSOAwdJaVGLXW+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071745; c=relaxed/simple;
	bh=/4G+GTHoPEqN2aynUXKndVGmoSw/qSrrQWQ8n9NGcTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oanSBBwf/UUAXiNg+vQXHWKA9+oijqV7C1lKlC0kNB83e4IVGZaKe2RN7OopQ6fvC7xreGrncDhThJUsYaHDL1bQ6aQ7RzheQL0PGsPp+x8nbRYCr243XXw9yZWNM5Yc6gG0OHoQ77aaY1jjYFahACURS/ljtNRjUf/+Fc4Tknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZ+5DMZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF5BC4CEE7;
	Mon, 12 May 2025 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071744;
	bh=/4G+GTHoPEqN2aynUXKndVGmoSw/qSrrQWQ8n9NGcTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ+5DMZmxDwXpbZJ0Ctf02n0q/NeiBcnRXkWuZX5/Hwqk0qdsLVfxJLsnuT9GSRuP
	 j2Sv9beAsQSz4pqzedvHHDTJmf3bnvvfVJiyXipcjJpuLUwhjuX4IDrdOa9koi5Zqs
	 O/XRBUBfmtIHV8p1ZuJNDwb1gHfkj60+Crex5czA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.14 013/197] ksmbd: prevent rename with empty string
Date: Mon, 12 May 2025 19:37:43 +0200
Message-ID: <20250512172044.886327678@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 53e3e5babc0963a92d856a5ec0ce92c59f54bc12 upstream.

Client can send empty newname string to ksmbd server.
It will cause a kernel oops from d_alloc.
This patch return the error when attempting to rename
a file or directory with an empty new name string.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -633,6 +633,11 @@ smb2_get_name(const char *src, const int
 		return name;
 	}
 
+	if (*name == '\0') {
+		kfree(name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (*name == '\\') {
 		pr_err("not allow directory name included leading slash\n");
 		kfree(name);



