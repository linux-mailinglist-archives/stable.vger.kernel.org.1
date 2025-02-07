Return-Path: <stable+bounces-114320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70EFA2D0F1
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD103AA754
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A61BC062;
	Fri,  7 Feb 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M44bJAJC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E861AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968648; cv=none; b=ly/glpDZBEA9vwISjI+YXwlo8zExF0ryHHhC5NZMKYaU7GshNzoAQjTMqk6Pcgv7pfjd2P5IY8ntp8ZbUXw/OUCFL09TCsLwx8hlTNTQ1PWW6KROVEcMAESB3q0MGe/ocxwE5OBE7WIM3zgPIhpzISpBjiK/WKlEU2tT4HqTDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968648; c=relaxed/simple;
	bh=sAR09xLXcpSii7IwgiHZ2sjlYlL5AO+7QP4QhOEAVMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yi5eLm9/syuQzMrIJqRQLAP9OeWbEFXR/zW7upWIcVHOlft+WfQQaF8rjnzBdrWyJE27S1U45sbB/94u2r4QlpXmJR9GG1BAysLFLGvXr9VqIYTJ5HHiQJ5kkvTdEZ6T7+U5bMSR3Iuw/f/e5jbXLCpKhAm2P2auSsyA43kada0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M44bJAJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5AFC4CED1;
	Fri,  7 Feb 2025 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968648;
	bh=sAR09xLXcpSii7IwgiHZ2sjlYlL5AO+7QP4QhOEAVMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M44bJAJCsm7IrlaDn+r/7VgLeXOtyyLPr/+kXA+jdVEcdi2tsG0P/oKdJ504NVZPg
	 5igfaIODiSwin0W4+oCHVFxDK9eSkGxK3IfQfhNcMw5QFXbclqUKtTGbcMCr9nyj4h
	 0G9FgqSitwlWNvgmV82vAfDz1Fq8lb1wUzdOYD/G478Fn7GY1pHIvZYlaGntsvPzbd
	 4lFEPQZGnNO7UB/dHRL911bP8/e6xN45RzGJBT/MtjuQ/hhlyAm7adSQ1TgsNXeSb9
	 4mNkN5lCYG+XkpvqfLYycRdM0Zfweqnc4BPipI4R3El+Xs6SgXKIJiiOW8KecSrkPd
	 1CssH23Uj7QWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 5.15 5.10 5.4 1/3] PCI: add ASIX AX99100 ids to pci_ids.h
Date: Fri,  7 Feb 2025 17:50:46 -0500
Message-Id: <20250207164207-5a696421fa6d214d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207173659.579555-2-tomitamoeko@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 3029ad91335353a70feb42acd24d5=
80d70ab258b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Tomita Moeko<tomitamoeko@gmail.com>
Commit author: Jiaqing Zhao<jiaqing.zhao@linux.intel.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3029ad9133535 ! 1:  32a751d45e995 can: ems_pci: move ASIX AX99100 ids t=
o pci_ids.h
    @@
      ## Metadata ##
    -Author: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
    +Author: Tomita Moeko <tomitamoeko@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    can: ems_pci: move ASIX AX99100 ids to pci_ids.h
    +    PCI: add ASIX AX99100 ids to pci_ids.h
    +
    +    [ Upstream commit 3029ad91335353a70feb42acd24d580d70ab258b ]
=20=20=20=20=20
         Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
         Controller to pci_ids.h for its serial and parallel port driver
         support in subsequent patches.
=20=20=20=20=20
    +    [Moeko: Rename from "can: ems_pci: move ASIX AX99100 ids to pci_id=
s.h"]
    +    [Moeko: Drop changes in drivers/net/can/sja1000/ems_pci.c]
    +
         Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
         Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
         Acked-by: Bjorn Helgaas <bhelgaas@google.com>
         Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
         Link: https://lore.kernel.org/r/20230724083933.3173513-3-jiaqing.z=
hao@linux.intel.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    -
    - ## drivers/net/can/sja1000/ems_pci.c ##
    -@@ drivers/net/can/sja1000/ems_pci.c: struct ems_pci_card {
    -=20
    - #define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
    -=20
    --#ifndef PCI_VENDOR_ID_ASIX
    --#define PCI_VENDOR_ID_ASIX 0x125b
    --#define PCI_DEVICE_ID_ASIX_9110 0x9110
    --#endif
    - #define PCI_SUBDEVICE_ID_EMS 0x4010
    -=20
    - static const struct pci_device_id ems_pci_tbl[] =3D {
    -@@ drivers/net/can/sja1000/ems_pci.c: static const struct pci_device_i=
d ems_pci_tbl[] =3D {
    - 	/* CPC-104P v2 */
    - 	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x400=
2},
    - 	/* CPC-PCIe v3 */
    --	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, 0xa000, PCI_SUBDEVICE_=
ID_EMS},
    -+	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100_LB, 0xa000, PCI_SUBD=
EVICE_ID_EMS},
    - 	{0,}
    - };
    - MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
    +    Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
=20=20=20=20=20
      ## include/linux/pci_ids.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.15.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.10.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.4.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

