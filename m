Return-Path: <stable+bounces-274229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uuQbHJI4Vmq81gAAu9opvQ
	(envelope-from <stable+bounces-274229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:24:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BEA7550CE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:24:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y4wZalMg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274229-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274229-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B1D431ABEFF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6C46AF18;
	Tue, 14 Jul 2026 13:14:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2639E9D5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:14:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034892; cv=none; b=YqVd8M2pmX2/1Lm3Z98Gr6e9EaC7vA0nskFAWRf+TPZjXwNt3R8UgyAjXuPL0NMaX4rjiLqItoauTa+GP71s0oafNAdT2X1GCjJ6liiR19GY4pupTSThvC6E9P+Q9TaabpeoUiNIBB2934LFKztBJ6e+wAVr6Txs98++U/a22mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034892; c=relaxed/simple;
	bh=UCBel2zhiaYu5dFqjTEjCTrbnvjgUBDs+YAhKN4u8M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoJkkfzF9w7iJRmiEEnB7rlTXEC+uQyFz8XdWGbIK3JYt+fSm4FaJPn45U3eRlZ7LsTfzdABbFgY4yYrabKHD3yzx6JGZyHGXp0kc6RXBtrZCND4DHhg0Eh1irkQH9HD7OYL50iOA6msl3mJTNBm/M804qdltln6b3EFMKrAWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4wZalMg; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451fd21113cso918654fac.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034881; x=1784639681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbwIZFBF8Iz6LqeeG2AP7ya8fzzPvitx0MG9ZNL5PZg=;
        b=Y4wZalMg4meLriclN6zI2cGRuy2GyLPJ7EscOUf3bD8QS8Y4qdjUtmPId7bqcjuv9Y
         +LBX8QKdTffEWzbWGhEk5NyxTn+sMpSWOZqUVnR2m/+A/O+LEQoNl392ZAsmZ6ci/RZx
         bs1gsA11yRRAW96QweYQVN5FeQtmVBaYZTuDumfAB8p8XVACJgSn+ub9o20mc/x+THY3
         blZYPcBFOvidJAHFqbysL9VbyVydlZRARKNV1pF/IKe3qB/07np6/eCmIFJxLk4+D8Lh
         YBTSN13QHXc/z6P+feGdvtFGEf22ZvQeQE4vXEgtlumjhUpW0AFScCUgyr4jBVbn55Cj
         BeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034881; x=1784639681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbwIZFBF8Iz6LqeeG2AP7ya8fzzPvitx0MG9ZNL5PZg=;
        b=CaxDHi/zZwGiA5+1e7LutXkQqfjqtLoeaXyF51yp67mFcJamVDX2/RTPWegpGzkDNN
         BQwkRlOvAF3DdZaU9inJweyM8XAzCWD0nmrgxQ1zHOajHMD47WsXk48sAlgXCvqAB4gg
         +Mf41uQ+8S2+mTWTfbPeBH82wJskUBPQP3RURp7iYrFOdXYJHLPOTnnQ+b0v5GOdpXeH
         Sq+jIS+PG/EQZV5QJxWNtMCdlHYiDZmazs2ScBhMO4YQZ6DKjvwAk2/ZP7xz9ylfONtL
         n/JSGlLZ46Ik6bRd66TX6+SSh4Qns/AFVHfsSueGZETSWJ1dYVW04VDKJfxqEQeMhqht
         WDUg==
X-Forwarded-Encrypted: i=1; AFNElJ8JQ1steMjCsafmK9stJCnF5EJCo4ejQa2U/Geoq/4mi8iRh8bczMl6lF4FgI6V5CsCj5FXoAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWw0WpMz1GYwdUh8pHiqGY0thVRP/rfO9o9Y729cC66O+hZ9+g
	Qum88sWSzYAJp5pTDAyFLv150AzGL9oN4pjlWzxMjzwN4siELaYddtSq
X-Gm-Gg: AfdE7cmj8whxmVgwh3Cm2xtSJm5CvS+JhbSbxvI3YDtbnZY8dR1yfrYenXAiKz/u1V6
	Lp+3Jgb3Q7ghtUDgXueOzPOOZ7cj6NNyILNh6BCeqtslwTCXnIWkGOBR6U7U7+ZWzwM5W0IUhvL
	BGg2LOWraLiFiCySjo8k8SFR+1/IueEom2WzN1mwlSXMFjK/I3MS6BpfkLatxA52GV695mgAdPq
	+l+JWStpv52QRDTFyXzo1Speykd6zELLugppVcUig2InKqiwh/8agC8aBeJcV5nYDRLwmqo9iuZ
	5I4941oOCtUx80YuZ98Q71Bqbr/rRoej+QmggLv9KTQXsEyOYLzo3QpaEwRLPH1dfAclq0nCLKR
	LEjMHM5wKpNmYfdKIzK76968d8e9LkIxPxWPjcX902dd1GcqEhK7JOieOunfK7gdnDpGR+g2pc2
	YQ+EpJucdh5Jw40+oCOCvXTa8IMHoQiQrE
X-Received: by 2002:a05:6820:1523:b0:6a3:7d24:7b8e with SMTP id 006d021491bc7-6a39be98f17mr5777449eaf.26.1784034881466;
        Tue, 14 Jul 2026 06:14:41 -0700 (PDT)
Received: from ChatreeyT9-N100.localdomain ([122.35.120.240])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38e9bc8casm8518384eaf.2.2026.07.14.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:14:40 -0700 (PDT)
From: teirua <qndkdrnl@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <error27@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MinJea Kim <qndkdrnl@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix inverted HT40 secondary channel offset
Date: Tue, 14 Jul 2026 22:14:21 +0900
Message-ID: <20260714131421.3980-1-qndkdrnl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alSVi8i-OB7Y51MW@stanley.mountain>
References: <alSVi8i-OB7Y51MW@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-274229-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:error27@gmail.com,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:qndkdrnl@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[qndkdrnl@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qndkdrnl@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8BEA7550CE

From: MinJea Kim <qndkdrnl@gmail.com>

rtw_get_chan_type() maps the driver's channel offset to nl80211 channel
types the wrong way around.

In this driver HAL_PRIME_CHNL_OFFSET_LOWER means the primary channel is
the lower 20 MHz half of the 40 MHz pair, i.e. the secondary channel is
above the primary one: rtw_get_center_ch() computes the center channel
as "channel + 2" for OFFSET_LOWER, and bwmode_update_check() sets
OFFSET_LOWER when the AP's HT operation IE announces SCA (secondary
channel above). In nl80211 terms that is NL80211_CHAN_HT40PLUS, not
HT40MINUS.

Because of the inversion, cfg80211_rtw_get_channel() reports an HT40+
association as HT40-. For an HT40+ AP on a low channel (e.g. channel 3)
the resulting chandef spans below the 2.4 GHz band edge and is invalid,
so the regulatory core tears the connection down 60 seconds
(REG_ENFORCE_GRACE_MS) after the AP's country IE triggers a regdomain
change: reg_check_chans_work() considers the reported chandef unusable
and calls cfg80211_leave(). The supplicant then reconnects, the country
IE changes the regdomain again, and the cycle repeats, causing a
disconnect/reconnect loop every ~65 seconds for as long as the link is
up.

Observed on a TECLAST X80 Power tablet (RTL8723BS) associated to an
HT40+ AP on channel 3 with a KR country IE; a kprobe trace showed
cfg80211_disconnect() being invoked from reg_check_chans_work(). With
the mapping fixed, "iw dev wlan0 info" reports the correct
"width: 40 MHz, center1: 2432 MHz" and the periodic disconnects stop.

Fixes: 5402cc178c5d ("staging: rtl8723bs: add get_channel cfg80211 implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-fable-5 bpftrace
Signed-off-by: MinJea Kim <qndkdrnl@gmail.com>
---
v2: drop the comment at the use site; the explanation stays in the
    commit message (suggested by Dan Carpenter)

 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6a97afd..967cd1b 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1957,7 +1957,7 @@ static u8 rtw_get_chan_type(struct adapter *adapter)
 		else
 			return NL80211_CHAN_NO_HT;
 	case CHANNEL_WIDTH_40:
-		if (mlme_ext->cur_ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
+		if (mlme_ext->cur_ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			return NL80211_CHAN_HT40PLUS;
 		else
 			return NL80211_CHAN_HT40MINUS;
-- 
2.43.0


