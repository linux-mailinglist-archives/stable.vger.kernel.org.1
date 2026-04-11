Return-Path: <stable+bounces-235749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAy4JguE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:25:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316F3E1030
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED46A301DBAA
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72F266565;
	Sat, 11 Apr 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFDDRXLk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840962DEA64
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928326; cv=none; b=LkulDJMlVWW0FJJuf4IWgR9WOuKm/tH3cxaSL7OPdCofJ6ovbRRbucLfpbQ+i9YiDU7U2bQ+0NFeTMPZZ7Fg79tSqgaoNR9nt3Nn2TCf6jjTcxBX8xkwa3HcOr8p46kcKxAjsy5iV8g7OGlfc1gdWIjNYJpBIAk8WcamxorKYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928326; c=relaxed/simple;
	bh=Tuw0emNVnOIZjZOyAWwN2ljYJKnUjn/6trIEUns70xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/4DK31vtnN/urM/0yxMD10LntrDzvGijYAWRHttMGtg7dvzJgjpPGUE7RdQrQPUcIsLXVok8qmCdrMveyTsYHc4JDCCQqXA287OLSGfJeeQnci8szG6DK00hpgMk2GpHWWT0Mmgh+EiR3ukqZGZ0WYCq7a4ketHFTqt7X5iAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFDDRXLk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so4512785e9.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928324; x=1776533124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MN+HVA/RjkCeJZrYT+pjGcZdWVMti7+q0Kfc2GJS5Kg=;
        b=nFDDRXLk74YXXQ0bdMSZ7P4VJFpo5ex4VXggmUjSdxi25eFcPAWJdXUeWA4oLvzt/U
         HaUMJ1xCabA2pD0oAvlJ4a6yfPs+q8D9A48qN5cgzS5je2RFAzLTy3olDbjoBE31EcLz
         xisrehLe2CcfKkMxK7ajugs6R6r44U5VfiRr/+bybJGJMLAkGfKbPLny1F6L5jRMePu0
         Jxj4Th48BCKWAPh44PBl92+uj1QbAzcQVFHzbKE3HpFIQhwP+Pnax8sGk2OAvVly+NHL
         O2cHnmq4gLzMbJ0VYwdnsp9r+PR+NlBHmn1FxkOfjTU2bBUA+eLp0ymbRcOrLe1gm/wh
         Cs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928324; x=1776533124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN+HVA/RjkCeJZrYT+pjGcZdWVMti7+q0Kfc2GJS5Kg=;
        b=qJ8Km0e9gOhlnQQIsGNBhrkCMjYAKDibXLRXSup4BwkqIbdnQiRPaZBfyuh/vRijmf
         i3uMJFNrxmZ5NOQYnshDK8hWX5Lialkjdvj8P+uO+9s7oe0v3wWUMNy73TJjLAjGvwKY
         5JCsBQiyWiDaiueDqzilwSr4tw3RfASsYI7nO9Y6POJ/bWzv6JQC0d9fX1k66PtaqRG9
         j+LPI3yPB4zg+hRw+cK84hDqfTiGIK6uBQGx3EgGiq1YVY+E6FfDXwfBoABs6IOuYV51
         mwSrNwVe1djaFiYVJrpFRJeAY9vbjO1cHloxra3Ubn76vI7PZZ8iTABXLpxRgmZvuKWT
         Dy8g==
X-Gm-Message-State: AOJu0YzhKok8LSa+HQR7PYw4KeU9JNE6S129rajldtcV0E32Cl/6FemT
	ortRYn2nEfRoVfA/v3jvo3tH1W2zAS0CaFjgKc3b8ygVard8XWakQfqM
X-Gm-Gg: AeBDieua6+ARYw9lz1yWIp2jGaddPDPaUXnl7FFahylMIgr0ClpGiNyEUctrj0SGXLZ
	fUxH9ti5KnFWfuPZWW+Ju21F9SAGhuIigf2guzjTHA5AfkfTbhgGWOxlNvxebABxCXAUDbjMGcF
	Ie4PjEgW/YqT/tOsUqrILWEUZcMwlepI+lec7wReQccjzsZIecJvL71V/oxcx/Ch5HrjAL1laYL
	3FINQaB5avMFmfx9hxdfcZVEe4c33ItRSx2FfBjnsbM2ZAtMl3EKq5ygrOEVJu1nyzDZ7KU4knb
	5U+EnBE5G2PSxcjNipJTll2Qi0nCUY6tvHvUCdtjJO2vqMvGRpvSwsZ5+/zqidvjBexO4/DFJ0T
	IA+W2pbidKF9JgRplfpNCVSGiffLs7Tbw7FNsLAp70107M5XSKkqDx34euhm0r4H2vLpBO1dp1e
	NbAjUvyjDMvvy9q0QYeLpPwQMMtPr2PF0UVG2eqRY=
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr94667985e9.13.1775928323572;
        Sat, 11 Apr 2026 10:25:23 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:23 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/6] gpib: Add support for ines pci_xl board
Date: Sat, 11 Apr 2026 19:25:05 +0200
Message-ID: <20260411172511.26546-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235749-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0316F3E1030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

INES have 2 pci boards that both have the same vendor and device ID
[16da:0011]. The older board is based on the 72010 chip that has a
number of extended registers that are missing in the 72130 based
board. This caused random error messages when the 72130 based board was
being used. The one extended register in the 72130 chip is the bus
status register which is at a different offset and has a different
layout.

The proprietary ines driver uses some undocumented heuristics
to determine which board is being used. In order to configure the
correct behaviour of the linux ines gpib driver for the 72130 based
board we introduce a new board type "ines_pci_xl" and rely on user
configuration to set the appropriate board type. The chip type is set
in the ines_pci_xl_attach() routine and the ines72130_line_status()
routine accesses the 72130 bus status register.

Patch 1: Add the chip type enum, the BSR offset and bit mask enums
Patch 2: Adds the 72130 specific line_status routine
Patch 3: Avoids accessing the extended registers when in 72130 mode
Patch 4: Adds the pci_xl gpib_interface initialisation structure
Patch 5: Add the attach routine for the 72130 based  pci_xl board
Patch 6: Adds the common driver register and unregister calls

Dave Penkler (6):
  gpib: Add enums for INES 72130 based cards
  gpib: Add ines 72130 line_status routine
  gpib: Don't use extended registers
  gpib: Add ines_pci_xl_interface
  gpib: Add attach routine for pci_xl board
  gpib; Add register and unregister calls

 drivers/gpib/ines/ines.h      | 16 +++++++
 drivers/gpib/ines/ines_gpib.c | 90 +++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

-- 
2.53.0


