Return-Path: <stable+bounces-248417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBHVOeZMB2rJxQIAu9opvQ
	(envelope-from <stable+bounces-248417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F48553C3D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9175D32497FD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A63F8704;
	Fri, 15 May 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="Ewks8CbN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42D3B6354
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861679; cv=none; b=DHAw30eNmITrELMA/EmOGXIoGOoT9GW7AVb65fj4UH+1rxfACemK8pAJFPKky68/zJ/rdE50zB3ys1tX7BLzRXsv5vXObE42l4mPNqGavuJdIxVARi8DCWv4oDdaoZV1cFwrtCIaa12CwOUoof8a0wquqDQ+mbaDlSdFYGFH6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861679; c=relaxed/simple;
	bh=8Wq3TI5q3Gtowm5CUBOhMSA4IQi4JYB6WkeRwgz2V3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meIPMGTlQG7Ib+5u1a391sBBHhY+KKQONfgn3Igqa69NMWQU6HRJbAl5Zl1Hk/wevZ4wu4NqinS0IUUA8Q7Nweiuq+WCj+excAgjbWb7+W+D2K4G1/NT1j7c5rDgdUshwHpjO/HE2+k/YPG2U9JhYbzPKyiCiqRXuNP/Jzx/lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=Ewks8CbN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd17e19b6so5414461a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778861677; x=1779466477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0UBnzwXbFcOfUkEKuZqlw1NGgS12LFn0qF26Q84UZo=;
        b=Ewks8CbNpMCYVA2aPFajixt9SewL6SfEuUkr8PVaScR5tzNUbhpsoQmJokz9FakW5E
         ddM+3YuFw2N7IBca4J1MdpG6b+W2ptbL+RogZNDoxw1SadxwqSn7afLTP7esHnuPMllm
         0s9MfwSfs1aW9tTCe9tRSRX7SYHcJVaBb9hlHSfzfGJzINFca7c5ikLYDGmxTBB8+AYp
         VMFgd6c9vpxmHqZcyrlh4gIc99ZnhrzGOeD92ZmywdAUgzLcoYv5kXlb7sUuDw867OR9
         bCEzy4TNJy3DghOolH4jO/nOMb6CbmVtbvwtcs5/D/rxis1aNUhq4rcdeZJjr6miiWSy
         491g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861677; x=1779466477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0UBnzwXbFcOfUkEKuZqlw1NGgS12LFn0qF26Q84UZo=;
        b=XNNP84fnidth04ou0BHW30rJdRRqig/vIWAHnCPc4U7B7TxAy+x8WlTvxpcm/+C6Un
         q/6oAWtvsHydY2UD387wqMnyIypTpr5cRmjW9XNcAn71P4X57LQNKpoIkp0I3SUDEO9W
         VOFbJp31mgV464817lrERVe2LZ0Rez7MTrLdhHfARias58/oUruLT4WbW+WcPvz6bBjo
         akB8rP7mxCcAgupWFqGEBvihW0E6WQKIooQevZQubQd57WplMjNIJewGsw5qg5FLGnB1
         QKhylc/z3MS0ZQx3b8u5T378L7tYM4P7FyfeoO+93wLZRh5rbQgLA/XOQOaUtVcmn4TY
         vXhA==
X-Gm-Message-State: AOJu0YzQQhKrD4g0nhSef717b83rGlQVzEwD1IPcXKe4JwDk47XOk9oe
	2XP94Ln8O1i+lO0HNRfHr80jFzFyfIvwHaz3BeMuMF03MwrurgNseJHykmYMJkTHYA563bOxS2I
	IM8/j
X-Gm-Gg: Acq92OEcay1G3BvLtZLUZ08j/AzLhgwdpb2VgDwcPts9pELzQ/L8+rFYCRXcx6DeigL
	LpOHqvYAfVRnBLoPW3viI5g+WRS/ZK/ZFmIQFowXeGHisaTQfSbjIuw7RPso9w79Y4tyLrCVmYV
	zMxMGrLkLRAQTEVafooXG0qUnpeiLb0gTU84QSTtr+aivmP6ycaRDpUglJ60K+eZ283K9hEmShs
	U6BJdG8DTJjU8B1ninJV1ry1yPepekYIcRTh7sknDCrWDhIhGcAmPOqhYfGa+9RgPA6QlUu/V6l
	auHKR9r2Ers+640i5aD8tIj9W8Y0RKFxdDTXWBoNAKwFpDQv3iIOB6lQwbYcSma6m+/ptQ0ATgo
	KE9wwySqQ+HvWD16tIaTBat+aFInrc4RF67shZLCdCPJDxeFSGoTqyDkSlMQLj1+HDxjw6IDbtd
	XDYXeImY4jOv49vm7GId2/nszYjIxkqsbd0WZzmdVO7kzLDQLGYwBqv4TqGrqw9mw8Y2/m93jfQ
	2cR
X-Received: by 2002:a05:6820:80c2:b0:68d:dfd2:8da9 with SMTP id 006d021491bc7-69c942a58d2mr2825044eaf.1.1778861677235;
        Fri, 15 May 2026 09:14:37 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-439fc1fc14csm4497662fac.6.2026.05.15.09.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:14:36 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.1.y 2/2] ipmi:ssif: NULL thread on error
Date: Fri, 15 May 2026 11:14:28 -0500
Message-ID: <20260515161428.2163036-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515161428.2163036-1-corey@minyard.net>
References: <2026051541-deflate-babbling-1b5b@gregkh>
 <20260515161428.2163036-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90F48553C3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit a8aebe93a4938c0ca1941eeaae821738f869be3d)
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 7c5a9c83afe2..e488a11782c0 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1869,6 +1869,7 @@ static int ssif_probe(struct i2c_client *client)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


