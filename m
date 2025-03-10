Return-Path: <stable+bounces-122373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DC4A59F50
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461C7169207
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F3231CB0;
	Mon, 10 Mar 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a588dKYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217322D799;
	Mon, 10 Mar 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628306; cv=none; b=Pp4CBEZSpIh6P6DxJpEwonyh+iRuqTwZSafPlCta7rTnisdKP7HcKXywN8aj+wqSX2m/t2VQq9FuP0Z2UqX+M25UnFGaJ1Dc12eqMsGZd8CDXxUsyB6jp5O42+no/VRckJNAkrlh0Wr3tc2FQ0YM9zcGDOAW0hD02di7nKmizLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628306; c=relaxed/simple;
	bh=2omAM1Wbqq4wXgjR+AtVYIKKmrrxMMbo1jFGq4O1nKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0KcU4iXsKHYzkQ8LiUonCQoRlMZjVnZpMPEDiW3qvbqdvOXNgqfdAKo7JL+MCU+tyx4rDvB9qqFQvF00t4Y6pLqbUPjxizQcE7Jas9MeDr8dVyf56M0vhjFN6xTEYpxfHW/ic0eogye6xK3Lh4JkccuM8cBqhe+BpEwh92r3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a588dKYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0ADC4CEE5;
	Mon, 10 Mar 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628306;
	bh=2omAM1Wbqq4wXgjR+AtVYIKKmrrxMMbo1jFGq4O1nKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a588dKYgD55aurMSeylgwliqNAfSRI5ibUUJvqUS/UmqQbUJOQyvgJTjtmLBwsUAQ
	 NjD8lwxSm+ddk7n1zjRLHmiFxOLsetsX9lU2NfJ1IVnohIH7/DbkE++Nrgd9LX6Nc2
	 L/7K4/C+b0SpNyYXQGl+M4VjQ8MdqATCv8r5g3+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 013/109] ksmbd: fix bug on trap in smb2_lock
Date: Mon, 10 Mar 2025 18:05:57 +0100
Message-ID: <20250310170428.081071657@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit e26e2d2e15daf1ab33e0135caf2304a0cfa2744b upstream.

If lock count is greater than 1, flags could be old value.
It should be checked with flags of smb_lock, not flags.
It will cause bug-on trap from locks_free_lock in error handling
routine.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7134,7 +7134,7 @@ no_check_cl:
 retry:
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:
-		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+		if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
 			if (!rc) {
 				ksmbd_debug(SMB, "File unlocked\n");
 			} else if (rc == -ENOENT) {



