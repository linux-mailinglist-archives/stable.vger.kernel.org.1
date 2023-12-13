Return-Path: <stable+bounces-6537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AFC810654
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A764F1C20E37
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA838D;
	Wed, 13 Dec 2023 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR1YFDjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78D631;
	Wed, 13 Dec 2023 00:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A26C433C8;
	Wed, 13 Dec 2023 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426489;
	bh=UZ2zTCvWv6lCFY7UVA9Fiyo6F47Tvt50p7DgX5662A4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VR1YFDjAl/F4EnHQpOiqKrcKEsKP0Y9KQw/GeEVD6wj0CoKm6fdmUUAR8ThZbBiWA
	 1o9GztXCiqaZP/GQygg5dx94C7/BTQskzzKdzMWwthdnw77zVWHfmJyCaB+TVxwUt8
	 YVD0KKfC/Lh1PNFeCMz2wRLsuXnYx+tzVzjJs1h9DMQKjRd7DgZcK0erZvDJzIsxlf
	 txYDR/psP7N4QoeG6ejNw7qnTsYe/+WW+U1sq4JMn1mALegSBv0/dYSFH2OBm7tdNV
	 VDPkU+QjDn6FPUiHLc6KJkWjAbcpiOS0HaCBvQb7A55xreusBJK01mY7Nbtv3KO/wf
	 Yp7eDvHF5iw8A==
Date: Tue, 12 Dec 2023 16:14:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Tristram Ha
 <Tristram.Ha@microchip.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ks8851: Fix TX stall caused by TX buffer
 overrun
Message-ID: <20231212161448.3ae3cb91@kernel.org>
In-Reply-To: <20231212191632.197656-1-rwahl@gmx.de>
References: <20231212191632.197656-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 20:16:32 +0100 Ronald Wahl wrote:
>  	struct work_struct	rxctrl_work;
> 
>  	struct sk_buff_head	txq;
> +	unsigned int		queued_len;

This new field is missing a kdoc
-- 
pw-bot: cr

