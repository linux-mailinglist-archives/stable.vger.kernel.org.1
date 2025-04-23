Return-Path: <stable+bounces-136411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F94A99420
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60EA9A525A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553328A3F9;
	Wed, 23 Apr 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lqAERMRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3C25EF8E;
	Wed, 23 Apr 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422476; cv=none; b=CX8uJ4vHmGEtLaPKW3+CdzFk4lQeIT8IzcGXWjPYeDcu3jc4zATY3Akqbgj0zlCsq8QghID6PM7Np6aY3WjrhezxYZkzDGSGM6m42FDa/BRaspUKSJ/QWSaNfFd2d3MUivNX9GiY9+uhEhKp0RYkI2SryW44ltGyYwfMp+FWQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422476; c=relaxed/simple;
	bh=lA07FVEc0Gz2OQSgfwhUHDTynY2T0srbjuPCD8ZAvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPwIoCG2EL9SuL8e4YDvDI8ouxIoMIPQ6hx02pR7QK6N6eYN2D2a7gyrHq+9MYnxh0S3edk8oE61mbwq1sBmR4fcrvSIa92VJFXbeoJ1oTClyG0+1BAv6kb1QxqiV5XrqkHyVp9Wtodu+FnZqKgnK5UGuSjR+cLvUXG49YBtXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lqAERMRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A7C4CEE2;
	Wed, 23 Apr 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422475;
	bh=lA07FVEc0Gz2OQSgfwhUHDTynY2T0srbjuPCD8ZAvOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqAERMRwScfKDJPsoum9DUaulp6fhlrjo4zwkn+gTsecIPkO/3+aMTQ61gJocshbz
	 XrfhRRvSzcM4876abW7f4w93s56v0gWe4azGcy+x5kKSYAjEL/to6+Bl536iAcmtOW
	 nbBRf+xHdtF2gOG8Xipd9KM++IGTcmvaoeLqqwq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 6.6 365/393] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Wed, 23 Apr 2025 16:44:21 +0200
Message-ID: <20250423142658.414795824@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

commit f6cb7828c8e17520d4f5afb416515d3fae1af9a9 upstream.

After devm_request_irq() fails with error in pci_endpoint_test_request_irq(),
the pci_endpoint_test_free_irq_vectors() is called assuming that all IRQs
have been released.

However, some requested IRQs remain unreleased, so there are still
/proc/irq/* entries remaining, and this results in WARN() with the
following message:

  remove_proc_entry: removing non-empty directory 'irq/30', leaking at least 'pci-endpoint-test.0'
  WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry +0x190/0x19c

To solve this issue, set the number of remaining IRQs to test->num_irqs,
and release IRQs in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20250225110252.28866-3-hayashi.kunihiko@socionext.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/pci_endpoint_test.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -260,6 +260,9 @@ fail:
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return false;
 }
 



