Return-Path: <stable+bounces-187582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5403BEADC4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873F594218F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E15330B3A;
	Fri, 17 Oct 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6ODFUNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EA330B00;
	Fri, 17 Oct 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716488; cv=none; b=YJPcA2DrzhmolbCTaTmdN4bcWdBIETRbNw0v9RrK6xD6ohehtGNYWB+vxMFeHOb93XIZUQPk0pMHKmM1+KKeCbERXE9dvA8eEeUst94EuhxpDyJltTo8pr8wmuM5IpUok6FCeYkPmU+ydsSjlBKWWLMXh1C07nhzjCoIsU1KmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716488; c=relaxed/simple;
	bh=IfnPV1xv5Gfpqjfz8kcG03pDd6RY0n0jkWjR/DUGDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcR7NZl+JDPwZMMwMMUbcwggmct8mhtJB9P5GvFDpmtbydMRzKiAM2u+fyIAVfjbi9EHoc6aFhKIHxNxAfZLK91RamujjO1qpJJlfc2ETSwEiwnJGUqEsIm35IP6U5BqXuw8HL+Qjgyte6PpK8Ak1msxSAUcTQ49NTmP0FmYZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6ODFUNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D14C4CEFE;
	Fri, 17 Oct 2025 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716486;
	bh=IfnPV1xv5Gfpqjfz8kcG03pDd6RY0n0jkWjR/DUGDTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6ODFUNv7b7NY6VNxiSUFPvFRP9VVue7UftcpAuNifs7A5mWsXNqfEIqbwO66K1Op
	 duVZn9QKrXyFqtD67MoZ4mZAbfJH5W9atXNL6ytU2EZNaWspJAPRCHOLkf5sAqflyx
	 E2LOzqxlk7UDO5cwrtiB0kOghHGujelfk3QqRhC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5.15 180/276] fs/ntfs3: Fix a resource leak bug in wnd_extend()
Date: Fri, 17 Oct 2025 16:54:33 +0200
Message-ID: <20251017145149.047194395@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

commit d68318471aa2e16222ebf492883e05a2d72b9b17 upstream.

Add put_bh() to decrease the refcount of 'bh' after the job
is finished, preventing a resource leak.

Fixes: 3f3b442b5ad2 ("fs/ntfs3: Add bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/bitmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1381,6 +1381,7 @@ int wnd_extend(struct wnd_bitmap *wnd, s
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		/* err = sync_dirty_buffer(bh); */
+		put_bh(bh);
 
 		b0 = 0;
 		bits -= op;



