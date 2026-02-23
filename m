Return-Path: <stable+bounces-217724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJJtE502nGnsBQQAu9opvQ
	(envelope-from <stable+bounces-217724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:14:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A517557F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D4C4303E3A8
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068F35CB67;
	Mon, 23 Feb 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JYoQi+NH"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B421770A;
	Mon, 23 Feb 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845242; cv=pass; b=CyrQ7tjdZRiqgUDWSYa/qwY9Mrd49Ec/aOK+zER8zrVXn3fn24ofskC+1nlftsBw1l9dvpw/zE9LnYnPOW8KCIDjyUPrU+bk1SAyPx96LwLR4fey8ILQKiK316ka188jPOF60zRX1WJnzCMOUe1kwQ0gsZBbgxp5vB3czjONg4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845242; c=relaxed/simple;
	bh=JRDaiMs2KAtrCCQY9S5E5Db1tU5X21ZS5TXgAhki0UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBerO1tfubqShb/VbOqwFjJ52hbXo7JqPOaLuubVqjuL/9Dgkddkb8e4sSdT0MfBlTIzejMgLV948uf4QrM0+M8DgOW35XpxcIcTHbyjDE72JM6qCahn7FNqo6HfBu0LE0u8VjwRKpk2ZssAK4D4jEvQI70ZGnwtnrfciGNCSs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JYoQi+NH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1771845234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TAj09Vc4VeX81NdMlcRp3dZyehQygv45dcwIBlMn2gRnq/D7mKHXLN7Qq7uepvBv7/jxacJt6ag39QaXTSrmGDWBCTlX9kBEG2GSsLE2YcoZbkZcUqLlIot3wQVMd8C21PURQJvngCjqKkKEuQR+LuJRMouQ+0YT1ghpLoATxYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771845234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6rry9lc+8ppJpTcNz8LoCA93qIEyl0rEmMFF316UV/s=; 
	b=hcvr07i6FGVQq9YKB32lwMWTYPf0VdwAdQ04+wOulfA9WEeD2NAj5cbTptyOBZ004Dl/AbzApVcuZ3vWLe6EqVF2j6OW2pTc6VXXRKE1tikrdNrnqOwtuMhzxrzDo7EefYNZdNJr/+ImV4jDSpLaDyJqeZWm/ot+Aqt9sfJfBzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771845234;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=6rry9lc+8ppJpTcNz8LoCA93qIEyl0rEmMFF316UV/s=;
	b=JYoQi+NHDUpl2nj/Aq1yNFVzs6MhUMEJqQUyyHXSN+aYn/7Cuo47VCOW5I8A6gR8
	JgJk0kgnHHyIgbSwAUBSaTvO9xtyWRNhvblyDY7/Mi5iOUDjMw11lcwYnMxj5LQQ2Ct
	vFdkkAIn5C3eTZZsjJw531ntfoKNdnK44p+YIr8o=
Received: by mx.zohomail.com with SMTPS id 1771845232254975.0000309439166;
	Mon, 23 Feb 2026 03:13:52 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: stable-commits@vger.kernel.org, stable@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject:
 Re: Patch "clk: Respect CLK_OPS_PARENT_ENABLE during recalc" has been added
 to the 6.19-stable tree
Date: Mon, 23 Feb 2026 12:13:48 +0100
Message-ID: <2819833.mvXUDI8C0e@workhorse>
In-Reply-To: <20260221160309.4048102-1-sashal@kernel.org>
References: <20260221160309.4048102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-217724-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,collabora.com:email,collabora.com:dkim]
X-Rspamd-Queue-Id: A66A517557F
X-Rspamd-Action: no action

On Saturday, 21 February 2026 17:03:09 Central European Standard Time Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     clk: Respect CLK_OPS_PARENT_ENABLE during recalc
> 
> to the 6.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      clk-respect-clk_ops_parent_enable-during-recalc.patch
> and it can be found in the queue-6.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Drop this, it introduces a regression and has been reverted in [1]

Link: https://lore.kernel.org/lkml/20260203002439.1223213-1-sboyd@kernel.org/ [1]

> 
> 
> 
> commit 17b0f85bf6339d9e275389fa4ba8c9d2014a1bb7
> Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Date:   Mon Dec 15 11:23:58 2025 +0100
> 
>     clk: Respect CLK_OPS_PARENT_ENABLE during recalc
>     
>     [ Upstream commit 669917676e93fca5ea3c66fc9539830312bec58e ]
>     
>     When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
>     operations, such as setting the rate or switching parents. However,
>     another operation that can and often does touch actual hardware state is
>     recalc_rate, which may also be affected by such a dependency.
>     
>     Add parent enables/disables where the recalc_rate op is called directly.
>     
>     Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
>     Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
>     Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>     Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>     Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 85d2f2481acf3..1b0f9d567f48e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1921,7 +1921,14 @@ static unsigned long clk_recalc(struct clk_core *core,
>  	unsigned long rate = parent_rate;
>  
>  	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_prepare_enable(core->parent);
> +
>  		rate = core->ops->recalc_rate(core->hw, parent_rate);
> +
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_disable_unprepare(core->parent);
> +
>  		clk_pm_runtime_put(core);
>  	}
>  	return rate;
> @@ -4031,6 +4038,9 @@ static int __clk_core_init(struct clk_core *core)
>  	 */
>  	clk_core_update_duty_cycle_nolock(core);
>  
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_prepare_enable(core->parent);
> +
>  	/*
>  	 * Set clk's rate.  The preferred method is to use .recalc_rate.  For
>  	 * simple clocks and lazy developers the default fallback is to use the
> @@ -4046,6 +4056,9 @@ static int __clk_core_init(struct clk_core *core)
>  		rate = 0;
>  	core->rate = core->req_rate = rate;
>  
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_disable_unprepare(core->parent);
> +
>  	/*
>  	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>  	 * don't get accidentally disabled when walking the orphan tree and
> 





