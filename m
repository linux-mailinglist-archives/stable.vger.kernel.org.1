Return-Path: <stable+bounces-83245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6BF9970E5
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE711C22243
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A4206E98;
	Wed,  9 Oct 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUETBDjs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EF1E5720;
	Wed,  9 Oct 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489222; cv=none; b=gbXBfq+tad0Qdc9TZndIKESX4r1QwzJnpl4E16OejiZSybu7hlMUga9Ovp6AUZUnsFVbHgM76uXbhOgdbyDOnoAsASpOZPP/eVyONsyI6rJE9AnKnvdNStWDK1zXHxWf4onabCDKmzZ2MWoJrkpb1ObtIDnIn8gsAbXydSLCO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489222; c=relaxed/simple;
	bh=hkK5Jrqrdm/FF4dGenxODFf3qC3kWUYM29Uxerw9Kas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqOfdJq2zC/1BbZCyJ7pJy4hAi/kzULgDKvzp5Op8EzDe/T/VP6h8dmpAoXGVYlWvqZujzky10x2sOVbQz6T4MdFm5hLjbazq/SDexzrUOplIDd1LEebaMwZXX66yr7lzsDIzgtKTiq6cYTkYkL67cdZpesVn9i1DP2hnQ0q61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUETBDjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8218C4CEC3;
	Wed,  9 Oct 2024 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489222;
	bh=hkK5Jrqrdm/FF4dGenxODFf3qC3kWUYM29Uxerw9Kas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUETBDjs3lURnCvaymWMfD1f6IyTvPZ+Zd2I3Cz95mP+xd0N7eE4keZWVVR3bK/zK
	 1TH3ILB/eRNcpmjzdTkqo/dMclMQzIVOjC+0XErbsfRtTWr5oE5PRpKroiMP95uu0/
	 1gWN2FPlQpXueDusYtqZkQzr20ZZhlSaz4c/suxN7hBI5/YRBDZ5tTJOiqiKfSnWKE
	 LnumpSx79x5ZgQkWQTlaOtJnJW04fObyPFJIgqZtcA6RbqK/Uvd2yCqpvdSfLVmKV8
	 eGRQavwHOhFBEFtOTkYaBCw+VExhW26M7yfdmranc5QZKdQe1Y+cZ3VzQngjqCEVyI
	 Ir3jkjx8SlW0A==
Date: Wed, 9 Oct 2024 17:53:38 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: "Gerecke, Jason" <killertofu@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, 
	"Tobita, Tatsunosuke" <tatsunosuke.tobita@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: Hardcode (non-inverted) AES pens as
 BTN_TOOL_PEN
Message-ID: <a34eifvhiqy7nu65pxcunjkvpreau57oizykk4mnzehkstox4r@h45cyy6f3b3l>
References: <20241009001332.23353-1-jason.gerecke@wacom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009001332.23353-1-jason.gerecke@wacom.com>

On Oct 08 2024, Gerecke, Jason wrote:
> From: Jason Gerecke <jason.gerecke@wacom.com>
> 
> Unlike EMR tools which encode type information in their tool ID, tools
> for AES sensors are all "generic pens". It is inappropriate to make use
> of the wacom_intuos_get_tool_type function when dealing with these kinds
> of devices. Instead, we should only ever report BTN_TOOL_PEN or
> BTN_TOOL_RUBBER, as depending on the state of the Eraser and Invert
> bits.
> 
> Fixes: 9c2913b962da ("HID: wacom: more appropriate tool type categorization")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: stable@vger.kernel.org

Thanks for the quick fix Jason.

You are however missing a few links/reported-by:

Reported-by: Daniel Jutz <daniel@djutz.com>
Closes: https://lore.kernel.org/linux-input/3cd82004-c5b8-4f2a-9a3b-d88d855c65e4@heusel.eu/
Bisected-by: Christian Heusel <christian@heusel.eu>
Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/1041
Link: https://github.com/linuxwacom/input-wacom/issues/440
Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Hopefully with the above b4 would pick those out without having to send
a v2.

Cheers,
Benjamin

> ---
>  drivers/hid/wacom_wac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 59a13ad9371cd..413606bdf476d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2567,6 +2567,8 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
>  		/* Going into range select tool */
>  		if (wacom_wac->hid_data.invert_state)
>  			wacom_wac->tool[0] = BTN_TOOL_RUBBER;
> +		else if (wacom_wac->features.quirks & WACOM_QUIRK_AESPEN)
> +			wacom_wac->tool[0] = BTN_TOOL_PEN;
>  		else if (wacom_wac->id[0])
>  			wacom_wac->tool[0] = wacom_intuos_get_tool_type(wacom_wac->id[0]);
>  		else
> -- 
> 2.46.2
> 

