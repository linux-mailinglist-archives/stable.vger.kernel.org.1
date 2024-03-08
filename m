Return-Path: <stable+bounces-27163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B317587680A
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3821F22CAF
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796B25753;
	Fri,  8 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVF0VGlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F31EEFD
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914015; cv=none; b=CJtDuBFLHu9DFKpUF0x7MjVVOaI4MdJBHctwpR0qjSYDGW+NsBK174xvrPmhvCIu6cFD5/NXEkT24kq4EUGYtnTFzbYlvSZurFyE0Jv+NwUrNnZzyJ9CdkJXWt5HcQehVnaTXmGmZi1fr1E06Xx5WO1Xx28yZRZXeTMpYRN++OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914015; c=relaxed/simple;
	bh=+kT+LKzEIymv4y/wM+gEVzBr/mCfK8gGTjkP7tWhr9c=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=G9tPnpvrNZTeV5Cxok846ig1APwGVPmope2T9npICMoVhdRE120FqHiX6nBmuid5c7sFbWq3HK8CenhHd/dYn1mwSWOp6AoValeC7K39+0aBEOiCVnn4kZHKc0T+zASok78IicEl0EszBM5RbHKMQQJeNVGI0MV/C2e4a7ero0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVF0VGlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392E8C433F1;
	Fri,  8 Mar 2024 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914014;
	bh=+kT+LKzEIymv4y/wM+gEVzBr/mCfK8gGTjkP7tWhr9c=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=LVF0VGlG1061t1NHUMFhUvn1aqkY3oX3lu5ssXZlw9gBJRCYP65opx6CXz9ePNrWQ
	 ezLqUKcO/fy6qJulTZzLIg+B8LHgwCcihiGnLV4YFA1DZMDYYZGfDQIB8HGil+vElA
	 scsFxwem4DTjCIqhAHWtatL8cYWuLhp7acU5IrBrTkLOFXO7hictjvlfwQr7tYtC/n
	 Wi15kyKopbjlr17urUwfpXr8QvirN7/YwnLSb9zPdCpN3ZZ8wv9LImIKr5ErE3gaLw
	 sD6d/o1Z37DCMqG0Phf4Q1FJ14jjX50dXnW1h+wBvKdT4/lSo89SZrPiXc3KN2UBLJ
	 G8RopOccX1zuA==
Message-ID: <86f312eade9ce0b6a07840b509ed1399@kernel.org>
Date: Fri, 08 Mar 2024 16:06:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jani Nikula" <jani.nikula@intel.com>
Subject: Re: [PATCH 6/8] drm/vc4: hdmi: do not return negative values from
 .get_modes()
In-Reply-To: <dcda6d4003e2c6192987916b35c7304732800e08.1709913674.git.jani.nikula@intel.com>
References: <dcda6d4003e2c6192987916b35c7304732800e08.1709913674.git.jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@intel.com, stable@vger.kernel.org, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Fri, 8 Mar 2024 18:03:44 +0200, Jani Nikula wrote:
> The .get_modes() hooks aren't supposed to return negative error
> codes. Return 0 for no modes, whatever the reason.
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: stable@vger.kernel.org
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

