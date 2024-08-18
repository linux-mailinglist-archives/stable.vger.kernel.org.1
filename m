Return-Path: <stable+bounces-69405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD6955BD1
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 09:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5956528230B
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5614A90;
	Sun, 18 Aug 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAArWeba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFEBA41;
	Sun, 18 Aug 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723966128; cv=none; b=X/2lhacAMIIHQEWACehyd+qemtCbsdPJgPpw3IKS7K1WtTFGPZFb+6YlmsSI6hca3TG2LLqemoxBF1zyU+c2I93w8+WO2s+RxNqpJVmIstu1PhoAO+YngzerQjoCQJEf/147/LBVJbXlXPcbnrdXbBCmrWmhYEDr3QKtOvOoH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723966128; c=relaxed/simple;
	bh=GKvPpus/+NOGjQDJYajGzzRA501OtgqRsEfEuZJt2/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YR+QLU3/AKttTKdJ6mJmQbvvoCATgDYUdDqN4ak71EMrURCXh8vuF5BqyX1E2xLc8m7Jn+j2LKWnsh5IHOqoefOMt/vfhHORMsXLFzPr9IvNSID9vfNZDJYGEW/yKGht1MqJezuXtW+VAgR7hrBFDpSUjZl894bLavhHSw5saJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAArWeba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D7C32786;
	Sun, 18 Aug 2024 07:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723966128;
	bh=GKvPpus/+NOGjQDJYajGzzRA501OtgqRsEfEuZJt2/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lAArWebaGY82aAuWaY1Dzg9d04r7rIx7qJLEV065/TO7IPsIz8GBg0fRvvMwLft/P
	 QLrsmiRXOQ1aN098XRxYSAMv/9XetRMvCoFDVDBmQwTTnuuwL2Uu8nwYclHDe2r3IL
	 BegLRZBklX/wQvZ2SZg2OmzMz/HcWxkAkQfvrLT1FmPaHOqDK+jQsy4EckVyXr+mSz
	 wojxUQSguulMu+Ayd79iHLCWHxYfH7uXzduaTD11bzOaeX43ow/HcEOQ3DI3O4ZTJ6
	 LNIArK0vL7P63kVwia4HfzbloypYHyYuHBd3smkHcTqEPwUdNLmylzKIlHxz6/HM5S
	 f3TUl7rYLLChg==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
Message-Id: <172396612475.999533.6561108954467438983.b4-ty@kernel.org>
Date: Sun, 18 Aug 2024 12:58:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Jul 2024 16:01:57 +0200, Krzysztof Kozlowski wrote:
> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
> 'sink_ports' - define which ports to program in
> sdw_program_slave_port_params().  The masks are used to get the
> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
> an array.
> 
> Bitmasks can be non-continuous or can start from index different than 0,
> thus when looking for matching port property for given port, we must
> iterate over mask bits, not from 0 up to number of ports.
> 
> [...]

Applied, thanks!

[1/1] soundwire: stream: fix programming slave ports for non-continous port maps
      commit: ab8d66d132bc8f1992d3eb6cab8d32dda6733c84

Best regards,
-- 
~Vinod



