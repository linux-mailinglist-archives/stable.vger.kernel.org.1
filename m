Return-Path: <stable+bounces-256513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHguFTMqGWp/rQgAu9opvQ
	(envelope-from <stable+bounces-256513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:54:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50E5FDA7B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D578301157E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13E3A962D;
	Fri, 29 May 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1NS+sMT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5D358D3D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034092; cv=none; b=N9NqGkxezC59TQ6K0YgYG2Lqku/xIpDrf2VQZMO3UGnP6CGAGhVzim4oe9s9qQcfXWYEQ7F+tTIPC1vVGVH1WSpR5q+Bg8Fg0ZJVpAD5h1oAnCPxfUxxwdzIw3b5UmoG2AzhukdkRcY7/DLA5HD6EzA55K11QuqNN2zYdexFEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034092; c=relaxed/simple;
	bh=pOM55M7Hh6LJ8cAI0nyMzwWtaxQDjjVKTNZtrLK4zDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShjnAXftZPWiL/WA2WFK6dfGZMEjl7mBJmfYm4vvmG6fdmAQfP65+qHQKJZ+8Bj4HeLiXc9IAhbjxGfVHPYH+cbIDbMQJ1dxkA6llCNRtiREHuEjHbaLjsHyLT6NnYY2/dV8dDyM2WF/f3MhSAu8DG3ZFRiNtQpx8KL2WdrEYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1NS+sMT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf008a99d4so16938845ad.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780034089; x=1780638889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEsG/2TRXcx3XobAj4Z4OB5JyGwYRCZYWn2stS6jSDI=;
        b=W1NS+sMToThU5SQKcICusI7Jmu/tGX4Xa2IPfVyUDC4nhrneIRep2SInnAzafDFEtn
         nJjaSpuRZd9jDkfwoqnU0o5cJqb/dgZIHSjOvg8nndSJHvhPjzVBh28S33kJ3bYvLho/
         DDR0MwtYtadKLr1GURVq/bGVER13mA2EJEonsZ1zehks1yJc8WvOpqo3+iqDrf+4rGKh
         c4DcbzXYhwK1e/iNMZXzLfCVzKwpz1cRVuhcoram3YSGiMoB8NRte3/N5bmir1SFFP7/
         ajoI5MFUw7rcM62RzV3EBCKXORrly5oARULbXGUWlNYK8CsjsEaTiHgEz7xd4Z0DCLhV
         Fy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034089; x=1780638889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEsG/2TRXcx3XobAj4Z4OB5JyGwYRCZYWn2stS6jSDI=;
        b=PNezpuBAW/C3kS7v1iYo1mgqBYB5Jmn/EXguODO/tF4w7PAWRuUGLCDGYdAt/5D0kD
         LZD/z17c9JN+0nBXXdHUlPYtqcIzFDnlqCDVWIxPMI+Es1ZWICyqIHcbx2N9Bktr9uNW
         +Tsbheegorg5bKDAQnNgzefyshmMsfi8bsZyiBIerYpN3LLdkDwTn1m2ThI5yh3+HQhy
         uKo8zhKr9bgBEjfaVCIJNtU/+/X+++3sNQziwIucBh0BQPcWcUSlOxJpMYk17mQLBNG2
         83g97LPxsboKO+ucu8YGxr1/UiVp8z0xDyMaUOxcFM1t2PuiT4zrOhKpgEcFOzvU5vz3
         yuug==
X-Forwarded-Encrypted: i=1; AFNElJ/ONaBP9zvNHT37HzzhnKF0wtjUKnxTaOeRuIo71lKWl7ZB+UZTmXestprwyH2nfC8Z3Vl2F7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx378Qz6isnIpfFzp6pbawO6mtinhZFcqDB01eWxG6qmRR/E6dK
	N7IV8x6Z/JhCM45Ge5nfFmmtPNYOddn1iI2d1UFngluRlibUsF5hnS1lpgnHc7BeFuRIAQ==
X-Gm-Gg: Acq92OFlnvxJlDOSx1pLo/KU+GJ9xq0TOs2bstr9fRQ9YlwOPKvFp4b3RlpubzbHgPs
	NUMUmu7R10USYFMn08oskzmKU54LHSKj2sspXKydU7g+rdToIt550XpB03a1RACPLDCM18OMLSU
	Qgt78bGmmlR83PwISrb0X6MfHUdqmDY8agkUUUJwotO/HjXjKRJy8wM2RSWbDVP502hALsY5Kxj
	+0huUmK1bu5P/sar8zTmZNytbilLnYL2fA38OkNKsKhX/kj8yqjzhXMydfbEpCxvk5Up8d9gZ5m
	REdehRIylautpfHrMrR3n3qezi/Z5lac3gp45IHQlPDFYCBne9fyH6ZPgS6R91IOiMAfSJ7tTNS
	2lkTJO5X+518iyf6XWe40smR8x83Elb6cn1A6D2SwOKmGzzdjTtvtAiMODhPC1QroNpxQfDQWHG
	LTsTBDYES9NeajBRBLqfnK1pgP3BWB2fgx5OYKcPVH5uyajNJScftyq2cAteD2HwIyulZmLlk0/
	GzF1EmxDQ==
X-Received: by 2002:a17:902:ccc7:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2bf20cf0d79mr18388915ad.41.1780034088737;
        Thu, 28 May 2026 22:54:48 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([240e:3bb:2e83:5c90:7639:89ff:fe18:ac64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a27ee3sm6335885ad.36.2026.05.28.22.54.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 22:54:48 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses" failed to apply to 6.12-stable tree
Date: Fri, 29 May 2026 13:54:39 +0800
Message-ID: <20260529055438.85736-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026052855-overhear-snowboard-a66f@gregkh>
References: <2026052855-overhear-snowboard-a66f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256513-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A50E5FDA7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Please drop this for 6.12.y; no backport is needed there.

The failing cherry-pick is expected because the code fixed by
d71c841be5d9 ("wifi: mac80211: capture fast-RX rate before mesh reuses
skb->cb") is not present in 6.12.y.

In 6.12.y, the fast-RX mesh RX_QUEUED arm is:

	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
	switch (res) {
	case RX_QUEUED:
		return true;

The later vulnerable post-mesh stats update:

	stats->last_rx = jiffies;
	stats->last_rate = sta_stats_encode_rate(status);

was introduced by:

	cc18fffa3a517 ("wifi: mac80211: fix missing RX bitrate update for mesh forwarding path")

That code is not in 6.12.y, so d71c841be5d9 is not applicable to 6.12.y.

Thanks,
Zhao

