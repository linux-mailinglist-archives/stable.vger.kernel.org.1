Return-Path: <stable+bounces-76500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7297A453
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07F21F230B1
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C52158533;
	Mon, 16 Sep 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNAw/DDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36E145341;
	Mon, 16 Sep 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497715; cv=none; b=bGvsFUrcHpZ0ZbpTWMPwPmY8xSXstHYY2aAoUMcIrl8epHbRCj/1tHR34wQ4/47aChhKuPjn4nR81qghKlKCRrOHjAgZEWLN3aXOu3x43iwLm001/XZ0Zyqiw98+RN3MOkOdaNPY1aUD7dfwei1Su1xObWN7Yc4+Yiu5mPu1538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497715; c=relaxed/simple;
	bh=TvNvTadpeWWADBUOxHDYrBzD2/aZE1g+HZQzSwjfZp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUy6PLKJUS3twfAXfSkM2xDPB88RLYgZoV37j/7em2uC6LQUVPHNjCslflDBt3NxbILeww+i1ixr7E3K4pcqPijFz7zYY8HJa27u5A7v7TabgHQu6Rxdth1nU5dO06s0xkcfkhbJrUN1eJKj4/vyPgCFb2NmBM9f1M4CGS+xxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNAw/DDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C48C4CEC5;
	Mon, 16 Sep 2024 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726497715;
	bh=TvNvTadpeWWADBUOxHDYrBzD2/aZE1g+HZQzSwjfZp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNAw/DDeFj0QqDaKKQSWIeAsZ8jmH1PUPyZFJCVIrI+S3dQVWrQVxUIV+dsIOAokB
	 xbiqYXKbl+2sXnD+v1paI4O9cu1oBGgfaDyX/eo8Y5pY/g8jhda7+/XLsq7dDGIg8C
	 7o13VNczctrnuB2cEEysSdSHHuCUArXXNs8IMzvMGhwIs3Gt0D4q+hlUc1EMDhT3Ue
	 /h7IcGSgEB8zrKoSNnSZG8pMefYfhe+kLlPNtnIniNO/aS9SoCFFbrHHofZsb4Jse+
	 Zta8wkJiFifxocCKxG7JDbtoHjJ7Rdh7TsX331Qv85fyWbtXdx2Z/LirqW5FYJNU/2
	 XkJMoOonDjTDg==
Date: Mon, 16 Sep 2024 16:41:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, 
	michal.simek@xilinx.com, git@xilinx.com, stable@vger.kernel.org, 
	Benjamin Gaignard <benjamin.gaignard@st.com>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: serial: rs485: Fix rs485-rts-delay
 property
Message-ID: <7hffs3njqqoavz4gtxbukse4c3zbdkc6ocwq5ku5dbwzz23lvr@jodq7fj4fnzx>
References: <820c639b9e22fe037730ed44d1b044cdb6d28b75.1726480384.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <820c639b9e22fe037730ed44d1b044cdb6d28b75.1726480384.git.michal.simek@amd.com>

On Mon, Sep 16, 2024 at 11:53:06AM +0200, Michal Simek wrote:
> Code expects array only with 2 items which should be checked.
> But also item checking is not working as it should likely because of
> incorrect items description.
> 
> Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Cc: <stable@vger.kernel.org>
> ---

You disappeared from IRC, before I was able to answer, so the answer is
here:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks.

Best regards,
Krzysztof


