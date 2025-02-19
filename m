Return-Path: <stable+bounces-118096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D81A3BA18
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A998800D03
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E231DED70;
	Wed, 19 Feb 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="de7Rqk2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B61D5175;
	Wed, 19 Feb 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957224; cv=none; b=MyLlw6FK44lzBS7Bdvbai10unR7LQnBrAiTsrxZvyWHzcqmomWuZ2py0patXimEuGwQhZ8sL/BuUXmB8jydhttGvCH4wkyhoVlUro9SL4jgRP5qfRDXcRwIC+jTc2JqqGu2XJXkH20TryXD85gseKiyfeSjnNYarZNZTuQ6S/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957224; c=relaxed/simple;
	bh=emzprnWGk+/rhfGqcEmNbECSlXQiXP5Pt/r+HuXazSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfjwg59e8+zNoqbihD3LdjfklYUE2dDa/iAYtUlzgwz16CKuhKL5ySxBimBZLIPCpPI9bo6S26NPKfpWgrWHDRzhTj5TeKd9TIutk0XUyuG4/1nUzQ3n9z3N/4YTyBEuUTmvtB0tNwsX/WdKE8AXFhk4KXGTQlGSczsuuOJyMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=de7Rqk2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D5C4CED1;
	Wed, 19 Feb 2025 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957223;
	bh=emzprnWGk+/rhfGqcEmNbECSlXQiXP5Pt/r+HuXazSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=de7Rqk2jycmtau3NZMT7CP4CRME9wLNC42JPl/xKmZAOwqWUx9zjGWYJsZDricPoX
	 oXKaWdsH1kYzeBl4rcj1pFzojB+jPHn+wpTv5+XPmh6GdSX3ZKkBMv9IwnIRILRYPE
	 f8Cwiul29Zc6Dcb0DbJsK3klJShPCIiEVf/nM8/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.1 420/578] nvmem: qcom-spmi-sdam: Set size in struct nvmem_config
Date: Wed, 19 Feb 2025 09:27:04 +0100
Message-ID: <20250219082709.539165893@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Luca Weiss <luca.weiss@fairphone.com>

commit e88f516ea417c71bb3702603ac6af9e95338cfa6 upstream.

Let the nvmem core know what size the SDAM is, most notably this fixes
the size of /sys/bus/nvmem/devices/spmi_sdam*/nvmem being '0' and makes
user space work with that file.

  ~ # hexdump -C -s 64 /sys/bus/nvmem/devices/spmi_sdam2/nvmem
  00000040  02 01 00 00 04 00 00 00  00 00 00 00 00 00 00 00  |................|
  00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00000080

Fixes: 40ce9798794f ("nvmem: add QTI SDAM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20241230141901.263976-6-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/qcom-spmi-sdam.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -143,6 +143,7 @@ static int sdam_probe(struct platform_de
 	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
 	sdam->sdam_config.owner = THIS_MODULE;
 	sdam->sdam_config.stride = 1;
+	sdam->sdam_config.size = sdam->size;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
 	sdam->sdam_config.reg_write = sdam_write;



