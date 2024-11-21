Return-Path: <stable+bounces-94528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C669D4EB4
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7E4B25572
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B931386D7;
	Thu, 21 Nov 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oozT5wUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA94A02
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199602; cv=none; b=YAcCnVYuWBgdcGQVcKO8NRgQclyURrNZmJWEwq2JRTunXUeOeaSTT106Y5kPgdmrTMdd1RIOe/686AiKJIf2sLvxVTrWTLrmtI4DiqyYsCTMO2hHva1X9fvbuTLZq1bV/zvn3w2Fa8hOtQLoaWiutIIS6oHGVXo3vAIU6dHNcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199602; c=relaxed/simple;
	bh=oHMJpJymB6/fAic/BoH3LDAeQ015R0FPilusKAakpcE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BavilDyDKIxyvJkD0RoSdZMcfaMV3+fK6byuVCVAmposYAwc6p165wnOwPiepg/A0hUnQn48FgazgolbyL8Azh9ckwaAWv2dPb4igTd77uxVn65vPE/fUXiwhzO2gaOSvIC8d3daVXCU4KRO1f0lN1yuTh+Ny5UzHxlYe9olr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oozT5wUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC5CC4CECC;
	Thu, 21 Nov 2024 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732199601;
	bh=oHMJpJymB6/fAic/BoH3LDAeQ015R0FPilusKAakpcE=;
	h=Date:From:To:Subject:From;
	b=oozT5wUpy85M7wImQFIG0s9KUI43lhlZXxK/SLMSilXrBul8BWyd+pdyXyzNp+/+7
	 +eQbwI9I+p1AyFytBatafnHa3lDNqw6W5/+dg3x626xXaqpDBYFbzEtvff6hjsWCyW
	 VerSWzOS/2c7yAgtzNGjQ8ifqDFmOPVkxHZslrbvQQpKQPNSSksBtHCbdBLRWHN9im
	 dbbnRNsA3bIrSMQSTTX0sltzYpdrD2yMQRMBJY2n8aWewqejuRQmMJD+VOnuRSE1SC
	 am0L46HtzX9raZ59/DS6w3o0stMmW+/RMcMJww+b+mfg952KjHZRN1tFIgN2a8dFF4
	 emzGj0jz7S9hA==
Date: Thu, 21 Nov 2024 06:33:18 -0800
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
Subject: please revert backport of 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <202411210628.ECF1B494D7@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable tree maintainers,

Please revert the backports of

44c76825d6ee ("x86: Increase brk randomness entropy for 64-bit systems")

namely:

5.4:  03475167fda50b8511ef620a27409b08365882e1
5.10: 25d31baf922c1ee987efd6fcc9c7d4ab539c66b4
5.15: 06cb3463aa58906cfff72877eb7f50cb26e9ca93
6.1:  b0cde867b80a5e81fcbc0383e138f5845f2005ee
6.6:  1a45994fb218d93dec48a3a86f68283db61e0936

There seems to be a bad interaction between this change and older
PIE-built qemu-user-static (for aarch64) binaries[1]. Investigation
continues to see if this will need to be reverted from 6.6, 6.11,
and mainline. But for now, it's clearly a problem for older kernels with
older qemu.

Thanks!

-Kees

[1] https://lore.kernel.org/all/202411201000.F3313C02@keescook/

-- 
Kees Cook

