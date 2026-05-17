Return-Path: <stable+bounces-249060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y0EVA0BJCWozTgQAu9opvQ
	(envelope-from <stable+bounces-249060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 06:51:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DD55F3FB
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 06:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F87300FB4F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 04:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F129898F;
	Sun, 17 May 2026 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSiXOuOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFFC8EB;
	Sun, 17 May 2026 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778993468; cv=none; b=JQOgSOPJ9DDmrMMEEeGFfE5eNxVbxEN5OzMu8sSxv1DEHDhj1jjZNigg63N2/KCDutI2NNVMviTyY9V9N0+It6IgfBicLO8FfkGwEQQJ6KxvT2CLXgR7ByxhQ5gXeRcG/1E0up1iISjiQMcdSv2oRkBZjk/hnIE5QkrrWI/RUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778993468; c=relaxed/simple;
	bh=ciO8vOfOu6EwzBNc5JX6xLvvZ06X1gDcGQ3IvNKZeNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h6ibJmsnu+RQGG7rGGEK1MU9fj1qMfpm5VIztpRWcxtfv8KmycCqT8+hjtn4pg7AekogkgUAqqzeXb+JnvYH5/Ud67HVxmVaOh1jYstHyZ2VC+OYaz0Mz7n0sqzFrQfC900XiiUYp4p+RrqhgOnV0W5LCCsEs3pdGFgZ3zUdIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSiXOuOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D541CC2BCB0;
	Sun, 17 May 2026 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778993467;
	bh=ciO8vOfOu6EwzBNc5JX6xLvvZ06X1gDcGQ3IvNKZeNE=;
	h=From:Date:Subject:To:Cc:From;
	b=dSiXOuOFbg5ZtQcE9FsaCkDlmkuLcRsbr7GH9meRQuVh8ySVU4JgTNZo1tddSj8hl
	 I1NEjpIMX/p90YE5/07oWMqtMtzesjgkKnL0KszoIbEeJ0mRj+WZxSLc+3YhNaR5gq
	 6fOxNgZ4+8/K4nasJJ+B3FBLrrm6j/bODNJ4137AyDtAUikoxVVlNE+Y4OETl2jwzN
	 CawwxZ9vnXY9Ow/fL/siIBHD6t+HqA0ox98rMhoNHA+ryJhOnhrfiWPX5eiI1mnMXq
	 DHymhqsVjFed3nkx0VNzmP8XaWRjAL0ZnMbhy1cMElOeoaMbNfuhaA8cMwXLXIN0Ef
	 aBQebqnFLFrrA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 17 May 2026 13:51:01 +0900
Subject: [PATCH] HID: core: Fix size_t specifier in hid_report_raw_event()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTvQ1BrRq0iRJvljx0VbZqqIp
 Xc36vKDx1vJoAKjc7WS4ikm01jgdhXFoR9vYEnF1NSNrw/uyIMkjpOCs7zY5I3rwjYjShYouzb
 1eR/akw+eymNWlO73v3R/2yPcEZfvlLbtA6pWc4uBAAAA
X-Change-ID: 20260517-hid-core-fix-size_t-specifier-14daf3b496b6
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ciO8vOfOu6EwzBNc5JX6xLvvZ06X1gDcGQ3IvNKZeNE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmcnpY+PaaLhIPmrlp4JdYyTKZzStX3sr6+J12ROzfnW
 78Nenaso5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkwUyGv9KfKitTnp448tYj
 O7f7Zm7dvg9C869FXb0+i9mMcYHpBwOGfzYSd6Uu32ruKfGwzgyQefwt4af7dklN98bgZ1yL1Wt
 r+AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Queue-Id: 606DD55F3FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When building for 32-bit platforms, for which 'size_t' is
'unsigned int', there are warnings around using the incorrect format
specifier to print bsize in hid_report_raw_event():

  drivers/hid/hid-core.c:2054:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
        |                                                                                         ~~~
        |                                                                                         %zu
   2054 |                                      report->id, csize, bsize);
        |                                                         ^~~~~
  drivers/hid/hid-core.c:2076:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
        |                                                                                          ~~~
        |                                                                                          %zu
   2076 |                                      report->id, rsize, bsize);
        |                                                         ^~~~~

Use the proper 'size_t' format specifier, '%zu', to clear up the
warnings.

Cc: stable@vger.kernel.org
Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/20260516020430.110135-1-ojeda@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b3596851c719..41a79e43c82b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
 				     report->id, csize, bsize);
 		return -EINVAL;
 	}
@@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
 				     report->id, rsize, bsize);
 		return -EINVAL;
 	}

---
base-commit: 64ffa2e5e02ff54b23221d0282155f37283fabea
change-id: 20260517-hid-core-fix-size_t-specifier-14daf3b496b6

Best regards,
--  
Cheers,
Nathan


