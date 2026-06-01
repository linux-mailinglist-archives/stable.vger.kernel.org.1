Return-Path: <stable+bounces-259566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM9BKjGMHWqKbwkAu9opvQ
	(envelope-from <stable+bounces-259566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:42:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F7620342
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 575393018145
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB903AC0FA;
	Mon,  1 Jun 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/c0xXFE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4B3ACEF7
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321289; cv=none; b=CLTrvE8FC65Mqp5bDFbpCqUdFCtyDQiYtjd9MVI7rEcZrolOYDrA+ul69Cfrp88lJhmH3ing4KPEGcX2V5r1aPwKrmrsdPzu4XgcZl1gVybqiIgrVFe0tGhg7FeTrd2k20GBclJnLirBaZacQtzIG+7F3T4rx4e7Qv1eJ9aQiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321289; c=relaxed/simple;
	bh=N+t2xw/N9UvZQMbKVq3rhJOSoOqLPghAmgvArJMgyts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnk0mlExF+Kwl3TMmUtK+Aaq1DT8PMqjB0D6AIGQX+TObKj0ccDvoOmZBoIQw3WSujA/RJcA2BRS+/g55Piha4eq5lVpKiJbptOg8KYL68XiFqHAe2SdvUt6GXRUA1GAE/7aa2fAqBF/q+gHVgpO3DAhwIhSF6yfA3rEtirOtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/c0xXFE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2423569a91.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321287; x=1780926087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7DVQL95atfUox+Ke0yfib+1TSwLTYfFcQgsjoIo9Eo=;
        b=S/c0xXFEl7KNvG5ZE+1U5I0ORxmV+ipRghuIhOgKJpfk1wVouBcmgWTtsDOith4YEx
         4Tnqfi8o7LBL2QFH87duhEoM8+o5rJnWsRmhuJu6/a9ArysacqRXwjBg7ZfzBnwd9R7x
         pJ5HEDA9nBdh+FIGG/NjYfJPBagSdQRlMPaQH8zJ49JkTdl1uZNoR9XyzBnUP7jQ+f1y
         3EONxk84ZvMm3BG/Bg9pP3MbapOtvZs2j/DGi3wWfxmSLj1kMzxNgiluOMb++1SHXonT
         OvmgCVLoHxVurueYvvniosZVj+MT97QSmq0x+Pha9GMgxyRn4XavTGTLRBczJd0ceTW1
         VSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321287; x=1780926087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7DVQL95atfUox+Ke0yfib+1TSwLTYfFcQgsjoIo9Eo=;
        b=Ow0IGhSIAS1l/whKLqfE5uiFYdPGL7DuRXew7rHtOdshpJQR4tMeLjZm5quVt5/YF+
         U7bHEwzNd89lQ0lfpDZ9jS0gC0dfEj0IYDyVHVymEfgGC50MLKsiRR0W0jJfW8P4YOlG
         J7wLA3cNX6ZdVNP6nbewX7INrBr6B3gZ4m/pS/OUTInAj1WTXMOsjx1EVCL2JTuxKOG+
         6h9xL5Tvhb332WRozgyioTFPlOGHy2K8+8DkFFdLz/TbdIRI6F6chAJK8AC5LtgXanvS
         8hnggr2CHTAuTnJbUJ4xFWFr6rvQ5b/hZ11oxjj+3tFWXGd6ndCyYI851rIdnLcK7tpL
         pD9A==
X-Forwarded-Encrypted: i=1; AFNElJ+856ITcqH/bltyUR65NUokPCXo0pcEJ1ZlBa8H4HWRaG7T7O+EkUvY7fPSwlKtJeHmxZPzf1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshiiUgPQESh4f6dtkWOdfh8i1sjnE0Ftsxsfw4ckMuJmVgcBB
	0q1XojQviCRtpuoy/zRH8GNG0CfTyNFOPEt2GBBhQeuSl1+KDU27xNk5
X-Gm-Gg: Acq92OEqM3ReJO1yovmA59Zpfas+QciLKB3sGX4qCN5w0AOY6bRc9wWKVqkuwTjd5Y0
	WKQrDQbf+QN4nMWdv2ZCFsAaFdOcaa+g+hkXUePO5j7DucUqB4EZppNNT2ADXIR/rdnGarjRsbn
	nC5eudQYEREPN4ElzbZZ0rSIcPE2a2q7bdNatn/xm/JHqJiXxAUUW4yjr3EIKUwV2ls9cs/MS4+
	6+UnagoZuv7HBj6dP+aBMZ/3uJqA0H9K+jXN1a/8+Eb2lZQlDdKMSG67srQn8Teu3dfrmwl0iiR
	39WG8LB5SBZIxsYx3B6JObpwEfGwKuhu8xFeoSDj3HOF3u/rxMo0sKftoUqkf1B/LDrRyKZumn6
	VmM5Ji6kloUUM/HHuE4FloSwiqsqgIHrbDbFzfMXwY4zcgitmPUZMlIy9uA2jNHS/hVaWWfpCrV
	FFNFqNt+/qOaxvbNGmSbOO5+bFdDlr0TGJPfxorUSb2oda0joSRwoSvMk6Z2E=
X-Received: by 2002:a17:90b:5184:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-36c501c16cdmr9130545a91.17.1780321287232;
        Mon, 01 Jun 2026 06:41:27 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm11496959a91.3.2026.06.01.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:41:26 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 0/2] HID: wacom: fix sleeping in atomic context in wacom_wac_queue_flush()
Date: Mon,  1 Jun 2026 22:41:22 +0900
Message-ID: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahu2oxLwkgMlwXu7@google.com>
References: <ahu2oxLwkgMlwXu7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259566-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A50F7620342
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wacom_wac_queue_flush() uses GFP_KERNEL for kzalloc, but it can be
called from atomic context via the .raw_event callback path. Patch 1
fixes this by switching to GFP_ATOMIC, and patch 2 converts the buffer
management to use __free(kfree) cleanup as suggested by Dmitry.

Changes since v1:
- Replaced Suggested-by with Reported-by for Sashiko-bot
- Added patch 2 to use __free(kfree) cleanup facility (Dmitry)

Jinmo Yang (2):
  HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
  HID: wacom: use cleanup.h for wacom_wac_queue_flush() buffer
    management

 drivers/hid/wacom_sys.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.53.0


