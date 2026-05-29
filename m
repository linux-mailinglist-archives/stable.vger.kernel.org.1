Return-Path: <stable+bounces-256512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN6gNCQqGWp/rQgAu9opvQ
	(envelope-from <stable+bounces-256512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:54:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 896185FDA73
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42025302FA58
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D97351C1F;
	Fri, 29 May 2026 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdX9W8R8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB53A544D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034080; cv=none; b=B3DehVWZch9qyRX9nBRVHKZwFdEu2k9noUp/7XgGEMRXv51a5VdSozco3YMsaymL3FaWs3geoKKpmeU5ysclRW25FRhbyWyMxHQZ4SeT0RNWBmANX7FLS6y6EaM+6mOFwLrfX03qPdI5oUFdw19mLg1EMQ/Sb7lROWNL7Mvfo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034080; c=relaxed/simple;
	bh=9c9peLJw7AYyyeDGPiM7Uhe0bFQq/gyTuH553Pf9cWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdrQ8LktIUBiO3dO/j/vHjz5wpeV4VKIYuaCtRW7nMrkGM8Zj7W10G6bV+b6/DY0i6hWFmdCv8HVQDG/ev2tlZBUALPBKG8Lg9eY8HjdSGfuVLZYOu7J4ODaCc5/UedYlykRuUVYZ0rrlH2Tt3paL6EEyexB2lINV7uPqjMCso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdX9W8R8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-837dfccd950so6355997b3a.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780034078; x=1780638878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMqelNw+jJisOXkeacobF9KfBa3dbuZfIXFGIAFHSyw=;
        b=FdX9W8R8cuDrTwPhAiTAwv/gAY/26q+9k8Z4oUvna0QnwDskldtueZJpJOfpZFTgdY
         HS0QfyWn9lPn69JSY1b7LIhi8YaDYokqJCJIILX8I7YEEFOIZ4/vK+9yFZB0Ux5BqIkV
         /cPbUuUgP2+3WXlO1fEI7kNWPqvuNX2tcajuqxYDQSXBsMuJ2In054Rw+xhTSEnZCbHa
         0mQkqDt8Z0KSY+v3b72nscw0NAg0xVKIYkBA7a/0pgK+lMGpgL7+eDtTw5ddbh+GyND2
         7srlBX6hJ1pwnPwn/Z5jLuiw7hSdaHrzmpNSEhhzb1RHe024MhE5rFkWBXc4toRv6Rwm
         6DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034078; x=1780638878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMqelNw+jJisOXkeacobF9KfBa3dbuZfIXFGIAFHSyw=;
        b=cxvN3/GsAb+A+eU4tnytJtL4NYgH7fr2Trr1uemJ3zDqKr6ye3kYGCZrXvWHcWiCaH
         cW3oKXJ8GLJD2SfLnUKVzXK4PBttEKfegMUc9KLWMUh0XPsB3gDfd+ds87/nZEpKzYPZ
         LqfQxe6pwUwYyrNvXDgA6tk2sbsmORSu0FHmjVCYkl3vgAJyvXHsaqAMfPKKVMHtmFha
         lFjhOlV3nRrbcFe/l9VVi5acsU3h/1dIiJYQcRX0KjTx8PR3REaMv865+JegpIG23zRN
         594X96eKuJi3mi3DpwuwIxE+lxsLacvoNlGOGT9z53mNHMpy1h2/j3eDUmfSPdFy+Yzb
         VAzw==
X-Forwarded-Encrypted: i=1; AFNElJ/ysb9HD63y5HkHPg4+cqV2ZSa8dFHUIV8A/A1XxgK+sA2N7zuLb1CiyiQR/wc6Mshix6mNnME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zVFMRSReGYMt/UEXbSSucXm50uA0/+udoe8cUvQlIBwT9Uwx
	zWzIVjmlO0cmKkiA5keQzuBRRjNBnvnBJCyTmGyHfNReGcE9QyRjn9QXHwb+i8ilRC4=
X-Gm-Gg: Acq92OFGvpUuH+v0CrZxKRl4+H4XD1JtQzoLvGIOLBU0EndXhk+bDW1XVKkA+PrO6kU
	N3moOHR9GTbdROyYyv9+bDYwWGgZU8CdE/1U2gGj4YKveYWdBpQZZwirSeSEwNYA3NXO3Y3SRu3
	83P4kZnv6kmWjBUvZW8MzZ/ONxQqlzgS1+zT26+Uk/Mw5IbAYrq+QMhbfMUD16CAu9QlS7W3ZPp
	YXa2ZDPUujZHOuhNweJjd+42MyiY28HqEyow5IbvmnMiYFPmqgkqguYS3toQ9nOD0yiHYe+1dx0
	ZxDcu97W3QfMC5sRSiNP894BfYbJFFKnTBvhMS9NnEE+lunQTL47ADzIabAgyg5PyRNk1gDCecF
	V63bm5DyZiDazO6pkHq0x2m1S48qgYUZmb97W9xzP5ZygXT0PjxZMukY7nGgRiF19d/TcyaYQ/s
	aHT7mxm0RnsJrHzO75xYLnShOiF9D8LU5/GLAUTtJfbiIswQeuNspuFloNr4LUjz0powOhH43ue
	yvhnzjfaA==
X-Received: by 2002:a05:6a00:9507:b0:834:e882:3280 with SMTP id d2e1a72fcca58-84212d35dc8mr1510319b3a.31.1780034077642;
        Thu, 28 May 2026 22:54:37 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([240e:3bb:2e83:5c90:7639:89ff:fe18:ac64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b30711sm595603b3a.16.2026.05.28.22.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 22:54:37 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses" failed to apply to 6.6-stable tree
Date: Fri, 29 May 2026 13:54:27 +0800
Message-ID: <20260529055426.85622-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026052856-census-broker-d251@gregkh>
References: <2026052856-census-broker-d251@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256512-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 896185FDA73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Please drop this for 6.6.y; no backport is needed there.

The failing cherry-pick is expected because the code fixed by
d71c841be5d9 ("wifi: mac80211: capture fast-RX rate before mesh reuses
skb->cb") is not present in 6.6.y.

In 6.6.y, the fast-RX mesh RX_QUEUED arm is:

	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
	switch (res) {
	case RX_QUEUED:
		return true;

The later vulnerable post-mesh stats update:

	stats->last_rx = jiffies;
	stats->last_rate = sta_stats_encode_rate(status);

was introduced by:

	cc18fffa3a517 ("wifi: mac80211: fix missing RX bitrate update for mesh forwarding path")

That code is not in 6.6.y, so d71c841be5d9 is not applicable to 6.6.y.

Thanks,
Zhao

