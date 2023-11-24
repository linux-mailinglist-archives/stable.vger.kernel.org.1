Return-Path: <stable+bounces-100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89AA7F6C7F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 07:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2633C1C20968
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3763C1E;
	Fri, 24 Nov 2023 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZiNHjP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62C5239
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 06:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C6C433C8;
	Fri, 24 Nov 2023 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700809123;
	bh=8oGVysG7zZuKUiOOlj+W5XkGwaErRlyqbLxjW9gwDgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TZiNHjP5ssXp5XzjwwL2tDf5kFi4FClHfHk6CtpdnfRN1hIYh7DaWwTlg/cO9EYhO
	 COlaM4KAdrsHUvCvzzlX6mKgVRr4n4xUwJn6njjhpB/0xwCTOh2gUCmGZWcBYoDaF0
	 LilvMfJHTiTQyS8pJjC3OQ47jWsj8JZ/aQyPtobwK00c3E189yDHmDR278fIOBpHth
	 LRHSkEEjvdZGQtZhJLGGJFi4BQ+s/jcmj7Rf13UAqm+0kxSDxni2lxExAEjEAudmwP
	 x2RyDg+dS7XE9is0AWdXOun4F0lHK0GxchlhIZ/5+2IFRbhAg7X7b3wOpCAJfMcR31
	 VAnWfaM4QuhZw==
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, 
 Bard liao <yung-chuan.liao@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] soundwire: introduce controller ID
Message-Id: <170080911959.720753.6925948247080380570.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 12:28:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 17 Oct 2023 11:09:31 -0500, Pierre-Louis Bossart wrote:
> This patchset is an alternate proposal to the solution suggested in
> [1], which breaks Intel machine drivers.
> 
> The only difference is to use a known controller ID instead of an IDA,
> which wouldn't work with the hard-coded device name.
> 
> This patchset was tested on Intel and AMD platforms, testing on
> Qualcomm platforms is required - hence the RFC status.
> 
> [...]

Applied, thanks!

[1/2] soundwire: bus: introduce controller_id
      commit: 6543ac13c623f906200dfd3f1c407d8d333b6995
[2/2] soundwire: fix initializing sysfs for same devices on different buses
      commit: 8a8a9ac8a4972ee69d3dd3d1ae43963ae39cee18

Best regards,
-- 
~Vinod



