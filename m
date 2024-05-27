Return-Path: <stable+bounces-46616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D78D0A79
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDA91F22777
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8016078F;
	Mon, 27 May 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bi950QqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D717E8F5;
	Mon, 27 May 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836414; cv=none; b=obbs17U7lidn5fXuomLWhiqrr1sdYgDQiuDnUiBxM2rxkpj42Ly/udRlZhJGG3ppebucxYyVk8A64Z9piEo6JrEf0NZRyWSLTS6bRxw2pLCO4laFeq7jhOPfSJqQyHoWrcc1eE8KBnWZKHVU/hy+ZMsmcMBdn4e+DneMCQ45oM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836414; c=relaxed/simple;
	bh=rMjOEU9/MHJ9+8+j6IM9PBveNtM58v1zFffNXP4EyoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chb5DuBoxFc6QUD6Lld5bCZxqPoLlTc+uhTYKifapZTui4BvGdY2oW7iixTrrYMAzhVKW3dgF+q6b5gK8o9s2i1oIa/fdNu3DXLCp0HIlAcbyDJo5s2o9J4g8t+NvZ7xoNu39YjpJGQOPXFGZIPQ4TnnyHAhsTWFFVRUPje6m+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bi950QqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA21C2BBFC;
	Mon, 27 May 2024 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836413;
	bh=rMjOEU9/MHJ9+8+j6IM9PBveNtM58v1zFffNXP4EyoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi950QqArg7HV4lBgYvfyAV5AwEpPyXQ7VLkU6jW33tXrQ11bHC6S/0FNlV9YDgOq
	 oaupZmOivr2nvRkqwctvUGcURT6pgYZm8E51CzeJxJuR2tWy+YAK8X3mOCbwmFca5W
	 PObRlmffomEnvztr4spLRw6r8crynr454fo7WnxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Simo Sorce <simo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.9 042/427] KEYS: asymmetric: Add missing dependencies of FIPS_SIGNATURE_SELFTEST
Date: Mon, 27 May 2024 20:51:29 +0200
Message-ID: <20240527185605.709286344@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 9d2fd8bdc12f403a5c35c971936a0e1d5cb5108e upstream.

Since the signature self-test uses RSA and SHA-256, it must only be
enabled when those algorithms are enabled.  Otherwise it fails and
panics the kernel on boot-up.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404221528.51d75177-lkp@intel.com
Fixes: 3cde3174eb91 ("certs: Add FIPS selftests")
Cc: stable@vger.kernel.org
Cc: Simo Sorce <simo@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -86,5 +86,7 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 	depends on X509_CERTIFICATE_PARSER
+	depends on CRYPTO_RSA
+	depends on CRYPTO_SHA256
 
 endif # ASYMMETRIC_KEY_TYPE



