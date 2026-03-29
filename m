Return-Path: <stable+bounces-230887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKOiIoMhyWkuvAUAu9opvQ
	(envelope-from <stable+bounces-230887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:56:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80312352085
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 485EC3002918
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84EA3603EC;
	Sun, 29 Mar 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4lTQ5Ki"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94C3C07A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788987; cv=none; b=XOp/xfNnmPdfFcHkxO7AET7whihsbfpxA75exlWp1XMVe4Rkw2sTgroiScQSwJB+SfFhzWrubtjKI/swD3VzFtTsufbT5LWmtEJmjYyjgsR5RgFkRpHK8wjjOpx7p9GivZjBpcXrS5S+46WywqZdPE5124TL1io0s/ETP6+B1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788987; c=relaxed/simple;
	bh=GwFUUbbu3aCwT6mUDpSWgsA4kk1QyljCVPUL+tdWN4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oppq3ZyBeKei2av9zb0N2ok1zNwwfOZGBS+fhhbxyM1IgLX+ZM3EDf1cnjtttQBrU/3FqiNppkOzWHHIyCWXBjqp8nGWZ/p4JC2HY1WO0xK2KCMoG1WnQiEHiCEtgR2U7JqMdninYjDEyWQo3Mk8CiiwoOUCIi5HziH1jugIpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4lTQ5Ki; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d357797acso2585903e0c.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774788985; x=1775393785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwFUUbbu3aCwT6mUDpSWgsA4kk1QyljCVPUL+tdWN4M=;
        b=m4lTQ5KidZLVLLcyi5QNrmV6AhjyyhV2CtuqERubireIJZymNQv/PxQPaEwHrPGslE
         QUKreMquEWUf5v2A/20p4JXvOGOuhFHPQKGIRlp81cA58D+hAnTrDaVigvJFHpUPd+qj
         jl2MsPZ6e97RCdo3Zw3tmInV618/StJQO0DUU304NfFsyz2j3R3NjT5hrlEb/H/neP+C
         P2granC4EM57xyjCdRfAtf78ZbO4jG0sF/f7S3onQ3l8ntyQBrN2saKLQQI8/nz9Qpdu
         WQjKmhiXS7IvsdVWzi3Qc3TDbwF4/hNJtT+YQDtaSjkEbVICcfho2shfVRUXgjwGbsGi
         Zo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788985; x=1775393785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwFUUbbu3aCwT6mUDpSWgsA4kk1QyljCVPUL+tdWN4M=;
        b=HWqamak9wKN5TUuw2ohwAaF1JdZWdbcLatonhFgrqzJo1V34E25zzr/rxNNMmWBm0b
         CFDS4uhTrjMnzSptFZXwEi/gosYSgPLoffjh0LUacVC5EB2dh+fNQFOzd/pIlSTm+H52
         NhFHkV9cpntsOlXbvZOYgyWwZ/7CrYZLUITQn9EeUHsty+RoLKwjFVG0YmLAP8qYHqcD
         /LSWmTJLAF/hwCmeWBYH7j12T8wlq3LYMDQi20C1ZuVhatbj5tkpEDITF7ZnG9A4gT0S
         5POd5OjPURmnE2EIA5WUp8bB7QtBKSKOVc4PKoE9gu+ceDeKksDz8Ba3kcw5c04eD1/+
         Vo7A==
X-Forwarded-Encrypted: i=1; AJvYcCVXuNRnwdUP6o+zd2UgyZv8ReiPOhn08xo4sWg9lj5wCj6sdjf8n/kb5KyJoZDCaWJnkKbLrB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygt4z4tq3edPPjoaIXbyYIBERywMX+YJ24dKP030mGGIAR0SVE
	FV5UfbuD/5X8fst7EAe9yp6gRoUeJWBrbZXQ+hnXrhv8oG+aSJBKNhjH
X-Gm-Gg: ATEYQzykHy36NPchVBRaOGYOyD2LLv9ip7LItLcxceNpqUcC1JvXWzVwf3DGh6ti4cv
	H+m4IQsl5e+Nb7CvJyfwv17TyAeQCbR9XkYOWiWEsT+JPKoeiCUrPDsmeZuDoiZTBCDa1D38Mvp
	/wzbFtN3+/XoBWONRXmYmkjajokYylAmn8gnrB00LeWxc7iiDHVGUiurB5NAdGam1tsrcAFJXgf
	dsIdxqJNTekSobOeHHm6oRYCiNPgxNcoz9g/1EJOPJmXmClVwy0A4M6FI1BMwvhkKVl5G+ICLgd
	xVAilO7gQBkZeqhUfciBKbMl5a8yr8ymgYmRcBccSZELOzRPi8gZ7+29T+HHpQMobqzF4lDQIuO
	YyvDAiX6QgPmuvk7Xf7rWdB5g6sPhc3j9TZXGDDH8/02PvguT/3DtRMD8F+IqdcwdE8xUCAkpZJ
	L78ClbyZTIJuKmtSmh3vL1dX5A
X-Received: by 2002:a05:6122:1d54:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-56d4a5fd9fdmr3778780e0c.12.1774788985323;
        Sun, 29 Mar 2026 05:56:25 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d77:aa::11:1a4])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a33bf3sm5188524e0c.14.2026.03.29.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:56:24 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: security@kernel.org
Cc: gregkh@linuxfoundation.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [SECURITY] usbip: vhci: heap buffer overflow via crafted number_of_packets in RET_SUBMIT 
Date: Sun, 29 Mar 2026 06:53:32 -0600
Message-ID: <20260329125437.517980-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230887-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80312352085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malicious USB/IP server can send a RET_SUBMIT response with
number_of_packets larger than the original URB allocation, causing
usbip_recv_iso() and usbip_pad_iso() to write beyond
urb->iso_frame_desc[], overflowing the kernel heap.

Attack chain:
1. Client sends isochronous URB with number_of_packets = N
2. usbip_pack_pdu() overwrites urb->number_of_packets with N'
3. usbip_recv_iso() loops N' times over iso_frame_desc[N] -> OOB
4. usbip_pad_iso() also loops with N' -> second OOB

CVE-2016-3955 fixed the same pattern in usbip_recv_xbuff() for
actual_length but missed number_of_packets in usbip_recv_iso().
stub_rx.c validates for CMD_SUBMIT but vhci_rx.c has no validation
for RET_SUBMIT.

Impact: Remote heap buffer overflow WRITE, no auth, attacker
controlled data, potential kernel code execution. Affects all
kernels with CONFIG_USBIP_VHCI_HCD since USB/IP integration.

Found through manual source code auditing.

Reported-by: Sebastián Alba Vives <sebasjosue84@gmail.com>


