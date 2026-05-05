Return-Path: <stable+bounces-244268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYbMnxd+mnmNgMAu9opvQ
	(envelope-from <stable+bounces-244268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:13:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509A4D3D39
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 23:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E04F130277E1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD648AE3D;
	Tue,  5 May 2026 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnQVSn5X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEA3CFF58
	for <stable@vger.kernel.org>; Tue,  5 May 2026 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015606; cv=none; b=tDrBhH7JXJHT/XRc26OdTFUJL3ymZW+Zdkm7dYzIt8xAXNZLxPeppIkC5pOaJT67l00cuLmb0nVOX1/4PB6uqbKh8mxN+x3fCef5wgECAIpkrdqJ8E3IHK+OIFpzM/cJEBn/rC+b5oRlacfNDNgkBqCw2k/S7/YzkPd1mzTh3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015606; c=relaxed/simple;
	bh=9K/q20kdv9UEMqCTifcl6QltCpdUFZ3I/NdHZCda5FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thK0dEamIn5otlxJop5neTU8W67Lu2lDodbKNYm4uG2x+S0/fV94MevquK70Z17rhVvrS8jXPWA472AF0BVFhB1HDrsojrD8DEMpBK7vAGtyoh3X/yvZBJWUJVDcmSzzY2WBWSPmuwd5Q8uZC9U0xG2KpWVUOSNYlz4U4OQ/HwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnQVSn5X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so1866455e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015603; x=1778620403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vtHOcfXlCeIRCIaOeTZhMJHEfAK35Rv4RbP/F/HJDg=;
        b=fnQVSn5XbsRPFzV7WjQSkYTbDNxWPlawIVVuF/bKr3MB8soA/HGdkrz+4qpcXBDj1t
         ff+w9V7HMDa/L0XqoXzCLCa8n/1LKVsClg0rujQrWH5O0XBq6IU2pobdm/w4gVnYM+Km
         th9/KMt+xiAufRZ4Eym1PMDAScVVEnX8FOt+dKGA6Q/fS+nN/EdRDcMgOsxCC5ACTKdL
         Uc3M7Wl4AujtOiFfQQFQfcOAOh3tivQqpKOXa+WrYsvL7Ih4Dpskskk+AjrlL7hU8BDd
         nLVFqUxftVRq6Sn5oJxfob8qCGHQQNtFji7KueGK4X5m2U7DjBMjGcyJ1vyyOaSwK9C5
         2n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015603; x=1778620403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vtHOcfXlCeIRCIaOeTZhMJHEfAK35Rv4RbP/F/HJDg=;
        b=pHveo/W1tD77wI3OkMs3Q+nU9k0BDoongqCRssVo3DoEVNKYqXX/hjowpdl17Uvdbv
         fFQsqHSnAc1+Phfqe3Gyvm/YtIs5OoUtyddBYgafd8PjWBCuLaLyFFOm1/Tc0FKfmn78
         w1fnq4qZHays/yzkOo4JCN5274ZstUotk4cNa1SC6j6F25PLGF4NjEviClNGk8WUvMr8
         eYQLn7Bh8H4+h4rlbkybi2TwwbRV1QNWDYK20lMOq2BoY4B5nc93IJ4gSWjS4lB58Qmn
         dQUsT/9FOlu8/Cm+c1TeU2nUWeWc5dhj3xdMWsvGYoCLjucE4v+R5PDCbkj5HW6mZbzE
         Atfg==
X-Forwarded-Encrypted: i=1; AFNElJ9qXbGJVC58FXCNUMJflBEzaEqlnkPk2WzUaZENz5tu4qjpb/5VYhhujkUjbegUN4SKnJ7PZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiMK2H5a+zEUyi+SNqd5W4ymn1FPjj4LTgAfzyeJnLpnAbqFH
	x4nC8pcSRZOl5+mgsETRU6fAvqtAt9Puww7+jhjQUWUxHXpVNzlUSO+j
X-Gm-Gg: AeBDieukinCYEQQ4U34JTjuErChb+QJkoj/AsragxUvcep+U1wmRMVtjDWOu5OqINQ7
	z4UyjbFhcGrSCftqfsL5wAqrPUQ0IOp+gIVwUNUbl+kAWJvQdoFk8uLY1VaQ1FdQy6EEuuKTH1o
	A+z8EFnN556MLm0SrfxDI8WVW4SyL0xqpFBU1iRg4Et4ULGh9G4R83krJTcHJnbfQ57RwkEb1YP
	OvV1qO5rGxwg97w4cBgbKAPIk2an2gejIPpExepBBOCe6i+kmfbIaelVkZbtc7CL7fCDOwUG7Hv
	P8wVXNaHV7wKvDmTwf9xAgTXPGL4KPnYxV8VDsx3AWKgVjDuQLs9KFkuyKxT250/C+rVzFlMf3w
	bbnJbSr47g5oqIb5nK2UqTrhYfx+KMJsubHYnTAV82FlTpkK1cktBjtqLT+NOTkvXFMvEbf3Lr9
	vLMXTSQR4ftNceYAAnlPWOmTMbrAlpgZB1YcovxvTqiFiiji2erQhzJODDDvnj6j+SfRxYjtRPu
	XDhExhSyd3MycydTFVgEa/+zkDvM/AObG4w+E9ZOlCMOs5fPhdTOSipUuSOktzluf9bd9k=
X-Received: by 2002:a05:600d:d:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e522c0909mr6320335e9.14.1778015603208;
        Tue, 05 May 2026 14:13:23 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6fffcsm403400045e9.4.2026.05.05.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:13:22 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v7 0/2] staging: rtl8723bs: fix OOB reads in OnAuth() and OnAuthClient()
Date: Tue,  5 May 2026 23:13:14 +0200
Message-ID: <20260505211316.3837020-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050453-scorer-rebate-3898@gregkh>
References: <2026050453-scorer-rebate-3898@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1509A4D3D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244268-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

v7, addressing the sashiko review comments on v6.

Regarding hardware: I do not have rtl8723bs hardware available.  The
patches in this series are derived from static analysis of the code,
cross-checking against the 802.11 spec, and reviewing the patterns
already in use elsewhere in the same driver.

This series fixes authentication frame handling in the rtl8723bs driver.

Patch 1/2 fixes heap overflows in the Challenge Text IE paths of both
OnAuthClient() (STA mode) and OnAuth() (AP mode): the IE length field
from the received frame was used without checking it equals 128, the
fixed size mandated by IEEE 802.11.

Patch 2/2 adds frame length guards before the first direct pframe
dereferences in both OnAuth() and OnAuthClient().  Without these checks,
a frame shorter than WLAN_HDR_A3_LEN bytes causes out-of-bounds reads
before any IE parsing even begins.  Two additional guards cover the
algorithm/sequence fields in OnAuth() and the seq/status fields in
OnAuthClient(), which are read at variable offsets past the 802.11 header.

OnAssocRsp() was already fixed in a separate series.

What changed in v7:

Patch 1/2:
  - No code changes from v6; dropping Reviewed-by: Dan Carpenter because
    patch 2/2 changes code from the reviewed version.

Patch 2/2:
  - Add frame length checks for OnAuth(): guard before GetAddr2Ptr
    (len < WLAN_HDR_A3_LEN) and guard before algorithm/seq reads
    (len < WLAN_HDR_A3_LEN + offset + 4).
  - Correct commit message: remove incorrect claim that rtw_get_ie()
    unsigned underflow causes OOB scan; rtw_get_ie() uses signed int
    limit and returns NULL immediately when limit < 2, so the wrapped
    value is caught before any scan occurs.

Alexandru Hossu (2):
  staging: rtl8723bs: fix Challenge Text IE length checks in
    OnAuthClient() and OnAuth()
  staging: rtl8723bs: fix missing frame length checks in OnAuth() and
    OnAuthClient()

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.53.0


