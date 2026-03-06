Return-Path: <stable+bounces-223387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EZEJ3tDq2nJbgEAu9opvQ
	(envelope-from <stable+bounces-223387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C6227C56
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C95BA300E48A
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813223F23B3;
	Fri,  6 Mar 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWQVhSmQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B4481A9C
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831598; cv=none; b=rLo2gZ/YbB3aF7E63cq5NOpQI89YYhPK7D8hx9RhT+qgxhZuQj2ua6bS2eztLM85xF8XC5FTeH+BcWy4G4xaqe9Lx9pLLTv3js9z5EowmWfMLyaZTi1zNp0fv5pWAkxiVe+uT9Byeq28Gq/0QhdBMWS8V7gXFf8IURnPs2oV34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831598; c=relaxed/simple;
	bh=qOWkm4KaoM/M/IJUqxWIPVIv0S9czaoP8RjOHXBNsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuKPeAG/qAWrqU9OlAhurawDW++q9A9Ew8GXMhBxSl4BF3UJDwtMnQm2LpT0gSXrTo+34gzxanhF/LyS9qbg9z81+Hf94H0xZLxJA6YFKCSUbX7b2alAs+2al7FYa7fTtWcXyU0omXTLDkQq3M1pHinx03O89Jyu3iWEf+QfsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWQVhSmQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so2965547e87.2
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831595; x=1773436395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf/zNSP2mIwbDjec2q9Q1Mo/k5XXLlz6S1V2sE7Q5Sc=;
        b=JWQVhSmQmi52tkEO1YchDWC/eCYAj/x0gfcyO/xf6LJuA+NCIs3VNzLOQFTOWLfyqT
         Z5zK2+pE6YSCa54BLyA9lT8vFEX6GNOujBLtW+h+Id5jedtojWGDpcx71p1mxpOYi1v6
         7cRozo2JPtZ14fZvYAEKeH6LBJsT1+P/m/afOnNXSsOehWtuiLNcTrwUh9wTlPOSokeq
         IYXwBTMHP2TexMqWcPLs82xc+Hl2ezIQKW9H0qQUnZ2ozNtDloiSau/vE2mrql/7qAM/
         YuWsXW9uuItzyCOs2XASaczBVWrTcdW7GQDCqrwc4MFit9sLbNFQbefsTySQ/Bv32pcX
         rcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831595; x=1773436395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf/zNSP2mIwbDjec2q9Q1Mo/k5XXLlz6S1V2sE7Q5Sc=;
        b=RDbGsGa1e4xB8MfYTYX8/pMoRg33nON884wYf/U5P9YlYa/Kju7iT8IrQoJhH4UYH8
         z71f458Mq1JY+YZVZFUx5W1spdgf7cgi892PBnmtanPkINXQo74wvldrfySEYutYMn7G
         esQVFf+vcijgV1BT5sQjf+OE4c22REbX7JtohMKRDsZyRF9Z8ocdBJxtGSOxNl5vOLqJ
         dXgdzP0bDQH4neaxoJwDel/DG6gJODq/CfL5skFoAnA/mc5ji7jNjnxQ6bBpvDB+zoA0
         hlw+nvQRSrtFeMYO+eSd18cuNGP2z6ttqolxD5hCMvj7eLAKN4YoFBi4MCjYCLmT8ntg
         YBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXZz0t2BMQ7IjQYl8ijqHxEZR8KRerJh/x0R2PpDya/9KLe4oywN4shTrYBo4XMxSS8DOEJkuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbjkuLMpX7F+x0NI4J3DHgGCSzmqXXLzgQIJ9vyO8ag1N3oPkw
	cl7een6Z3dN5ybWRcuGAPgYJZeySSLh173KXY1wxoXsfCAtMgLu+2l9Q
X-Gm-Gg: ATEYQzxlFnb64r4dOyvYMAYPLtUczSGDU2cyofXJbIQP/fSwn+yRoC1Msau6MRpy9Kg
	SJ2AiOPl3h5Lq+3dzOhMjmNOE6GF6IrrB+7RU6YJ9HgfvY+j6XRtVCo2AU7QOtSNWVGiEX/jOd7
	2nZ+pgGhuHcdbFY7LDY32sWezH6AMpiumwtBGThXrgNaxnVcWH9KSBPzv1e527UO2VABIKm4NdN
	dwVvxZJY5JJHWBzlVOv/ztqyDVfsb3E4WXYHX7yao0i/DTfFmIRABThFNCme8c4/s9ytZzUM3A2
	5eyFoEUWniqTtbugxhDpH2shR6JJGEGGLEv4ZGtMULHaL4Le3sXjzLhnFn83y8HTkpc6LM8Q0gg
	cmcOkH46BAkZ6urp00lqcPKEcCDypsx+l+ipRmcDtESrK6lndu2wCP3Pb7NFYMnoKmuWV3aoTpY
	cbQKkp
X-Received: by 2002:a05:6512:1315:b0:5a1:3c21:37f with SMTP id 2adb3069b0e04-5a13cab3728mr1533744e87.7.1772831595025;
        Fri, 06 Mar 2026 13:13:15 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:13 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 0/3] igb: fix TX stall during XDP teardown with AF_XDP zero-copy
Date: Fri,  6 Mar 2026 22:13:07 +0100
Message-ID: <20260306211310.1213330-1-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B33C6227C56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-223387-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When an AF_XDP zero-copy application exits while an XDP program remains
attached, igb can permanently stall a TX queue associated with the
AF_XDP socket. The interface stops forwarding traffic and typically
requires a driver reload to recover.

Reproducer:

  1. Attach an XDP program to igb
  2. Run an AF_XDP zero-copy application
  3. kill -9 the application

The TX watchdog eventually fires and the interface becomes
unresponsive. Reproduced on Intel I210 with Linux 6.17.

igb_clean_rx_irq_zc() lacks a __IGB_DOWN guard. When the AF_XDP process
exits the XSK pool is destroyed, but NAPI continues polling. The
function then repeatedly returns the full budget, which prevents
napi_complete_done() from completing. As a result igb_down() blocks in
napi_synchronize() and TX completions stop being processed, eventually
triggering the TX watchdog.

Patch 1 adds a __IGB_DOWN guard to igb_clean_rx_irq_zc() to break the
infinite NAPI poll loop.

Patch 2 prevents igb_tx_timeout() from scheduling reset_task during XDP
transitions when the device is shutting down.

Patch 3 adds synchronization in igb_xdp_setup() to ensure that pending
ndo_xsk_wakeup() calls complete before the teardown continues, and
refreshes trans_start after igb_open() to prevent false TX timeouts.

igc handles a similar stale trans_start situation via
txq_trans_cond_update() (commit 86ea56c5b0c7). This patch adds
equivalent protection for igb during XDP transitions.

Tested on Intel I210:

  - AF_XDP ZC app exit with XDP attached
  - XDP detach while AF_XDP running
  - repeated XDP attach/detach cycles

Alex Dvoretsky (3):
  igb: check __IGB_DOWN in igb_clean_rx_irq_zc()
  igb: skip reset in igb_tx_timeout() during XDP transition
  igb: add XDP transition guards in igb_xdp_setup()

 drivers/net/ethernet/intel/igb/igb_main.c | 15 +++++++++++++++
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 +++
 2 files changed, 18 insertions(+)

--
2.51.0


