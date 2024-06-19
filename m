Return-Path: <stable+bounces-54597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F7690EEFB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8BC1F2158B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC0147C89;
	Wed, 19 Jun 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSYySrHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72B146016;
	Wed, 19 Jun 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804051; cv=none; b=Q2LOAIgJnTxEr6S1HdHd3QJSGFPzErFc6JRhL2OdD2BJfK3YB8+23wBwsNOpzYgoeaaZAuakkLBrFN+cdg1cseYiKsvt0LIgF+JMioew9yR4viCNqcu0Tpn1bED7wVfRih+VwF/JkAgNMjYsTuZhK/ERkahIPFQeYqpYOjK8iDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804051; c=relaxed/simple;
	bh=VxaGJTECBnItZ+YmM2Giauq0Ue7cPRa1ubp+JKbl5Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k69OXAIg2UGBID0q5ZcH6OkKFBJrDEYoAP4wN9QzoJnntaiqkYMtIx+SOm4mC30E8jzH+YTVRNBvlH5vm5EfGA7WqkF3EyAhhnjk3E25kZurvaNf01wnDrCZGBxrQhNZFz3086PQAXK6T1NkW69zpCohfVTHqs7KREqLkQDzUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSYySrHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B59C32786;
	Wed, 19 Jun 2024 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718804051;
	bh=VxaGJTECBnItZ+YmM2Giauq0Ue7cPRa1ubp+JKbl5Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSYySrHqiiQMP8HcUoBmM7lyKbVTLU9VttBd68s5iCk+NUb5Qd3e+JxxJTq8YkMYS
	 n4nmrdQFvhAdpie7VqZ3K7vavattF4z7xWV9QY/OtS48P9BwNt/oW5zbXZ1uw5WWWP
	 RT1Kv6ajadoNVaeXZi0fMBLVi+f7H49ZujLhSd84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 6.1 192/217] intel_th: pci: Add Meteor Lake-S support
Date: Wed, 19 Jun 2024 14:57:15 +0200
Message-ID: <20240619125604.092248014@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit c4a30def564d75e84718b059d1a62cc79b137cf9 upstream.

Add support for the Trace Hub in Meteor Lake-S.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20240429130119.1518073-14-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -295,6 +295,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Meteor Lake-S */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



