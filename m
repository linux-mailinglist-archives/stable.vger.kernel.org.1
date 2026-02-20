Return-Path: <stable+bounces-217555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H7hIHUzmGleCgMAu9opvQ
	(envelope-from <stable+bounces-217555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:12:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D591F166B59
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A2C330031E4
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF8323411;
	Fri, 20 Feb 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSIGQVuM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449C2BCF4C
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582320; cv=none; b=CDbHkofX4pb2rn4trqo74OB85xhHyeQd2px6s/8Kzhc3MrZVnEq65g9zG2CwkWG6H6w+vhO5R3f5H9+MPrH/QWMb2dPv4KY/6oPzcvSXYGrR3tYUju1nxeIE69zyMas1HZGdZMOkJdo9RwSyuKqWe6mE8C7nVK5Imn3S7kDy9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582320; c=relaxed/simple;
	bh=6eGWr3H780PQ4tTMZavzMacgOr0bw9BFvOMyrG343WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKkzKpiriXYQJwPPiI04POzW1zzD4wwzuSftfBRV3BkrGWa/Y6L4s29CN+ghMD2cBLl+pRwUnFR1ZOow4SuJYbLaOXzojA+itVaF+hS+RRFOuhnxyTqA3hUtlYmQwUcCauawsFURUKuHsHVGs6g6krZZbvtr1wBYhR2YKZy4/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSIGQVuM; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5662c2937fdso1803231e0c.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771582318; x=1772187118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuB9Y2YaYrSJOMH0MnZVGF4L2Pbe5s6knowQ2Ay53LQ=;
        b=CSIGQVuMODWwDg+q7zbPcX9H0WD7vb4goSdU7BChwRRNZM7TFVgqtSe36YuR+5w3U8
         G4bQVHWZDIkgTAU95MkcVizM8TQLSIAYETwD2szHEV4yTymDOF+G3yifQOpl02dwRrzb
         iZgQz6Tyt46Gg5IXrWkiG6ka3j7rR0CWH56/56OgrfoRSiuii3oe6WYkZ9t6/bFxBNCr
         rUC4TyVWbv12AcHKZbGfn9aZnK5MTaRBAXmFBYpXZKiuyYi0zKT2MeBj7a+WDH5N++TI
         zL7lLto/NnC18ee2C2xmO7UdDxgabaNdH6FBhWvtSG6hQiAx4LXO0MrRTkO3oM2juHU5
         DWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771582318; x=1772187118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuB9Y2YaYrSJOMH0MnZVGF4L2Pbe5s6knowQ2Ay53LQ=;
        b=k/sOUhKAOryhtvA+MoEavhNSGR24TSc6xwZ/g5ofOqAUUPpTn9QMRwPdveS257/Wt1
         kAk76Uc2lZ8DfJOiF1DhHRF5numbbpjcSPDCG7DxkVE/MUWXU/t0Qqz/3CGWo5JjIzzH
         GLjYXGjFZSkBfX6Cxrv5Olb20xmjtlCGt8P39+1h4jpqTPzjiWolH7zXBMN5wFyBFzEO
         xx8yGLhFSBxNf4JZhC36gkmDnjtuJtynYV4zEZbLeD3hYKlUm0+xGNK8cwxFZL162ZfX
         TzQRmEnA6Hgb8iAdUkxsaA/h4hhJdakqhwvvxT+ogtsOvyvB6VNazK73/bPfnECwCugH
         35ew==
X-Forwarded-Encrypted: i=1; AJvYcCWMI4nMXatvthGjgdpHEkPc6+vtC5M/FCi3pk7zOqCp9Jlg3pQtTL3xcMDzNwPLb5If9/WYV6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbaIS6+wer9Ha8Mmn92PsgR2LtCsQm/fG8iRrshbNMh5PATqO3
	swk70nhjHrIll70urK4bGYgxoOtNtcndx8wdFei4E0cqxEB00iV1evEZ
X-Gm-Gg: AZuq6aICrfnrWZMVyQFaPSNh0mHgQMYf/EANNbxwvdvOQxIZHqC29gzQRsCiivOvc5R
	Tz0QdSwQS8z4m/vWOBLfgBauqGJlejin/rSLiBCfooKLxPTuR3z0SCXKF//4q6fcC30Xy0Y9+iv
	jfio3kEWo2XtApnyJ89GxoKlrC6TgfhHIwj4JW6XMSxs1vOWA+Deh0WwqWxzqm3F78455BXKV0C
	qnMH+7Gh5B2K5MmYG+tp4ur4cRm0pz9WVO5iqAhPr797vMbQuxq4LVv4PuAQOBgPXG51wJKJ4pp
	FaCqpCqBX8y0lV71mRP6h8sT5own+pRWUnUqvBPpTYccoWdkv6nw2mPaMdAtcMBY+KhuXvRwwWd
	uY9MHs3GTf6VcUq40DwTRUcayLBagDKPzf7n755YoIHt1QWVh6utHD6RC6Ge/Lz+iyvCQltKm16
	F7WUB6BfnRq8nsaMpfu1RngZ5maYu9GD3x+aHelkLDtfw2hHEYTs145954EzPrTh6jQ/IOojvCc
	BU4QE/lask=
X-Received: by 2002:a05:6122:1dac:b0:567:fb8:c7ea with SMTP id 71dfb90a1353d-568cdcff321mr2699908e0c.8.1771582318351;
        Fri, 20 Feb 2026 02:11:58 -0800 (PST)
Received: from vm-ubuntu-ariels.. (250.54.231.35.bc.googleusercontent.com. [35.231.54.250])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20b0e5sm16892349e0c.12.2026.02.20.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:11:56 -0800 (PST)
From: cr-ArielSilver <arielsilver77@gmail.com>
X-Google-Original-From: cr-ArielSilver <Ariel.Silver@cybereason.com>
To: johannes@sipsolutions.net
Cc: torvalds@linuxfoundation.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Ariel Silver <arielsilver77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration
Date: Fri, 20 Feb 2026 10:11:29 +0000
Message-ID: <20260220101129.1202657-1-Ariel.Silver@cybereason.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0fdab034a93626704d84eefbda652f5bfcbeac7e.camel@sipsolutions.net>
References: <0fdab034a93626704d84eefbda652f5bfcbeac7e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217555-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arielsilver77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D591F166B59
X-Rspamd-Action: no action

From: Ariel Silver <arielsilver77@gmail.com>

link_id is taken from the ML Reconfiguration element (control & 0x000f),
so it can be 0..15. link_removal_timeout[] has IEEE80211_MLD_MAX_NUM_LINKS
(15) elements, so index 15 is out-of-bounds. Skip subelements with
link_id >= IEEE80211_MLD_MAX_NUM_LINKS to avoid a stack out-of-bounds
write.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Reported-by: Ariel Silver <arielsilver77@gmail.com>
Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
Cc: stable@vger.kernel.org
---
 net/mac80211/mlme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7073,6 +7073,10 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		control = le16_to_cpu(prof->control);
 		link_id = control & IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID;
 
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			continue;
+
 		removed_links |= BIT(link_id);
 
 		/* the MAC address should not be included, but handle it */

