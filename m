Return-Path: <stable+bounces-240171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGq4L06C52k+9gEAu9opvQ
	(envelope-from <stable+bounces-240171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C35ED43BA0F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3E763014791
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB843D75DC;
	Tue, 21 Apr 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUqiSiTV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D83BAD99
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779811; cv=none; b=qeNvDc7KH7Jmu64I/btiH6qzNKSkZKfYSZvaJG+dg1aLhbQrU254eCmPIzDMy3EL6Ct8dlxh82VeR6oipjXkSlU/nvjVKrDhDPwQJ3XaRjClSaJCOfM/VlUfk01iQuI9OLEXY3SaithTTqUPY/P+suW5yvLV3v6KllkRVTga+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779811; c=relaxed/simple;
	bh=xRR4YXHdNTwyaJomNKqEyxWDMa347weKXyNstaeXji0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9SIMaYq3LC1obEPa2aj+mpw2swWhfg5tE/eOR6OTGxsxDR894C822143Guil3o+kOhQvlY5OiIS6Obxim2/0IAgk7jwKhLSqX1js72Q9cvq7d6k21ZqoxtaNOQvJXULY9CX6dceFPWa4RIhZjh7kzw7NeCDixgTM3u9CqDwME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUqiSiTV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ea8563c693so257923685a.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779808; x=1777384608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpRWGV/9h2J0e2y4smv95jEfx6BRtkOqUuKuvF+USRA=;
        b=dUqiSiTVJLFNcIZJS9f3M9GROVSh0fq3yXxyAktO+Bkrm48rhDyLlx3YC0YE310mYJ
         pqG69K9VEpGhWylwLTvvOhZ0SchIhA1IV4o3obyKghiKwC4i4W8TqFKLVHaJT8p16aL0
         Uyji6AMUf3kVPerUTCf2j435+M95U/XuppBSOV7bjDRyiBz7gDYfq4hzwu+AZxJXJqwH
         dCD8BlWpBPC23iltp6BuEIlgfhoJxM3K7wBwM+N31/v45p76ys9YhXhqF6LHi52HWj/3
         0c5MiloTaqtUtrxHx7luFfj16M4zDDGkG0CxzI7oBUmmZyZIHfX6PoQaUZCWsh2IgK+p
         bDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779808; x=1777384608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpRWGV/9h2J0e2y4smv95jEfx6BRtkOqUuKuvF+USRA=;
        b=VLZwWx618tEmWx5LkcNO4n6QYsRxlR5ogtyqouoxluop69eoJBWsdWzy20g1j7sEvA
         GeiDFiqRKv3n9R1eefDi0JbyB8Nk3EEX7fRArpSCH4HZ3dUnkOPXfEFXLRqExKzRkqlt
         fyJ5D8vPSb6YxDhCc3HlbP5ODizWNuEaUYfGrtCYK9i026G3/zJk0uSn7UPka9cwa4bt
         Cp3isFNJfSY7fWCWuE7/ogeFcV403FdCObk0zstQ+FD9G9OKUbzQteDCDSpbaGP3er9x
         iyeinD3d5Cv7NLcdKGcdjxbMrPnOsFKXa9XU2S7BInlLn7WGDkgIUKpWreIvnHtVzXe2
         cYIw==
X-Forwarded-Encrypted: i=1; AFNElJ/VFoQvjvcUuTIPRpr4igXhTO0K2Ckhg28gg8idZmRpwCovQGzSKym+0NRnmMR+NrBUfSeyEqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSK9XP8mAtdQmGUn4N6UyD17s17aItESh3WNwXIdGu8dacRDb/
	yI1CfiOmnkStlrB8Fd9x+5txXvsRx4IwLl9m23k9Dcxo2kiQm+XeiZd2nd6S142t
X-Gm-Gg: AeBDies4f79htv4jSp5056VM0nrDtcm19QImp31m8nLEp1QvKrTKpX9TAddip0SbRA8
	IEYmKoebrdNBj5J7KaQlTL5PhLmCiTt5RSxwQR1sKq4/hnQ5FQkXi/4RfOUA5xoWovJjmC+XI97
	Gw5aTG9/+vqXnAwFvxSixtnr/tPniNEMAlQuw2xVQdrXFqISBwRKtiDVWBs24TlkpFidDnDmHpF
	+2E/FRquXWrEcgtZOKkk7/8JMyUaXSLpAXq0tMeS33VSg38uymJ+3Gxz9AT9xGzAhN9LnS7yVcY
	x+Ob8mhQt6je3n10Ej8mD9poH/fkgWPQ+go/2IFuz/jslUzloNjp762s0tVwnKq0pqfMJWaZt+u
	lW7L/HKxKQdMwKA76gLuqp5vOR70y69IqS0fx0AuuJD3YfLSvBcvT3NZa5hU0QJ8xDK3X/pRsQr
	4C8yagFA7NyTPlSv/D/Xrt4PEiTbVW03GMOyMJcJD8x2l5xCfRgMoRxcyp5YRIIpPxYONDWiaMo
	nYbRy3gEyt298y6YJWkEUzHBvePO1RjaU+l8G9XgA==
X-Received: by 2002:a05:620a:6ccd:b0:8d0:ad0:c026 with SMTP id af79cd13be357-8e78fd1ee3dmr2532149385a.21.1776779807613;
        Tue, 21 Apr 2026 06:56:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: L2CAP: fix zero txwin_size handling and repeated CONFIG_RSP re-init
Date: Tue, 21 Apr 2026 09:56:37 -0400
Message-ID: <20260421135639.3185653-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com> <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240171-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C35ED43BA0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz,

Thanks for the review.

v1 mixed the original zero-txwin fix with a defensive
l2cap_seq_list_init(size == 0) error return. Re-checking that path
made it clear the reroll should be split:

  1. keep the original report focused on zero txwin_size, but fix it by
     normalizing zero window values at the actual inputs to the ERTM
     state machine and by making sequence-list teardown idempotent,
     rather than by introducing a new init-time failure path

  2. handle the separate repeated-CONFIG_RSP ERTM re-init bug in its
     own patch, matching the BT_CONNECTED guard that commit 25f420a0d4cf
     already added on the CONFIG_REQ side

While auditing the Sashiko comments, I also checked the claimed
CONF_EWS_RECV bypass. I did not carry that theory into v2: in this tree
CONF_EWS_RECV is declared but never set, so the concrete zero-window
paths are the plain RFC option, the local L2CAP_OPTIONS socket setting,
and the CONFIG_RSP / conf_rfc_get negotiation state.

To make sure the reroll covered all the zero-entry sites (and only the
zero-entry sites), I enumerated every assignment to tx_win / ack_win /
remote_tx_win / txwin_size in net/bluetooth/l2cap_core.c and confirmed
patch 1 normalizes the four reachable input paths -- the local
L2CAP_OPTIONS setsockopt, l2cap_txwin_setup() on the outgoing RFC, the
L2CAP_MODE_ERTM branch of l2cap_parse_conf_req(), and the EWS / RFC
branches of l2cap_parse_conf_rsp() and l2cap_conf_rfc_get(). The only
other writers are the channel-create defaults in l2cap_chan_create()
(hard-coded to L2CAP_DEFAULT_TX_WINDOW) and the outgoing rfc.txwin_size
= 0 assignments in L2CAP_MODE_BASIC / L2CAP_MODE_STREAMING branches,
where a zero is spec-correct and never feeds ack_win.

l2cap_seq_list_free()'s callers are l2cap_chan_del() (channel teardown)
and l2cap_ertm_init()'s error path; clearing the list metadata after
kfree() is safe for both and is what makes the partially-initialized
re-entry in the failure path no longer a double-free source.

For patch 2, the BT_CONNECTED guard added to l2cap_config_rsp() mirrors
the existing one in l2cap_config_req() (lines 4339..4348 in this tree)
so both sides of the CONFIG exchange now refuse to re-enter
l2cap_ertm_init() once the channel is already connected. I did not
pin down a single introducing commit for the CONFIG_RSP side during
this pass, so patch 2 keeps Cc: stable@ without a speculative Fixes:
tag; happy to add one if you'd prefer a specific reference.

Changes since v1
----------------

  - Split the reroll into two patches: the zero-txwin fix and the
    separate repeated-CONFIG_RSP ERTM re-init fix.
  - Dropped the v1 l2cap_seq_list_init(size == 0) -> -EINVAL defence and
    instead normalize zero tx window values where they enter negotiated
    ERTM state.
  - Clamp the local L2CAP_OPTIONS txwin_size = 0 case back to
    L2CAP_DEFAULT_TX_WINDOW.
  - Normalize zero tx window values seen during CONFIG_RSP / RFC parsing
    so ack_win does not collapse to 0.
  - Make l2cap_seq_list_free() clear list metadata after kfree so later
    teardown cannot trip over a previously freed list.

Michael Bommarito (2):
  Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
  Bluetooth: L2CAP: skip ERTM re-init on repeated CONFIG_RSP

 net/bluetooth/l2cap_core.c | 39 +++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_sock.c |  3 +++
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.53.0

