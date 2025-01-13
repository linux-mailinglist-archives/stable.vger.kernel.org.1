Return-Path: <stable+bounces-108381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B589A0B2A3
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80804166366
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3562397A5;
	Mon, 13 Jan 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXu/XkJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C1188906;
	Mon, 13 Jan 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760264; cv=none; b=DEgmdccZelcdtQDlTr/MerM6GHOfq1b9mutgVPW2TkNguAVQFNc9KaRX0U+BWdmVM8SPwoeo5yM6HSblImRcz78+PLEtl0/eqNmkdndIDp3tw2/gXboNsN+0EFWWLpadgKItFNfEZfr63Z8y7qcVkKKYVeNj+a5jbDJhpcImxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760264; c=relaxed/simple;
	bh=O8ogNUi16IzOoAKmrNzGLQ/V2vo+Dds9Q28JEu9S4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q80GjMo9bm+EHz4ljhP90FZy17CZsjKB4eKctJQ/v4QDHGk4YnE5iHxGi26EgIONJjZGLU6yVAUqUqobNoS10AuO49dPsqoxoIbc3CJ6iKgiY+YuKIRHjSCzr5JaNSn/T6/ES5sBz4JvDMFMICe5pcid9uEiE1z1tq8vyJEW2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXu/XkJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B2C4CED6;
	Mon, 13 Jan 2025 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736760264;
	bh=O8ogNUi16IzOoAKmrNzGLQ/V2vo+Dds9Q28JEu9S4G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXu/XkJGzu45wBlW3MJDvuGnlOv69IDD9OWaVob3zI34ULXVuJeVlxgPCV0UkySUB
	 VWiHTSTyF0MHH0/ZhQv8uT592YGp8o72PEwK5CpfhQB5X269MUJoEUnwhyBvcFVC7+
	 +oiwNeF602ZA1UqfgAUHTaG75pGtnRrBw+x2c4N+9YxhKq2PJG2RPfYtIu4AIdV/Gt
	 +T4mb7gE8Ob87w5YWw/q4DzBsI3S+6WyhgUJKSQxagckg5gbc7TsqyVCydWuuSuXSC
	 2ONtmVnWFOjfna56GLuhe/M8ZuFNdZPvXBg7U7cOhdymiAPNuljQzj7SXo3AfY2l2r
	 giEVJ+E1zwylQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXGgK-000000006ce-0PzK;
	Mon, 13 Jan 2025 10:24:24 +0100
Date: Mon, 13 Jan 2025 10:24:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Steev Klimaszewski <steev@kali.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Bjorn Andersson <bjorande@quicinc.com>,
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
	Cheng Jiang <quic_chejiang@quicinc.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
Message-ID: <Z4TbyIfVJL85oVXs@hovoldconsulting.com>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
 <Z1v8vLWH7TmwwzQl@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1v8vLWH7TmwwzQl@hovoldconsulting.com>

Hi Luiz,

On Fri, Dec 13, 2024 at 10:22:05AM +0100, Johan Hovold wrote:
> On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
> > For WCN6855, board ID specific NVM needs to be downloaded once board ID
> > is available, but the default NVM is always downloaded currently, and
> > the wrong NVM causes poor RF performance which effects user experience.
> > 
> > Fix by downloading board ID specific NVM if board ID is available.

> > Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> > Cc: stable@vger.kernel.org # 6.4
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> > I will help to backport it to LTS kernels ASAP once this commit
> > is mainlined.
> > ---
> > Changes in v2:
> > - Correct subject and commit message
> > - Temporarily add nvm fallback logic to speed up backport.
> > — Add fix/stable tags as suggested by Luiz and Johan
> > - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
> 
> The board-specific NVM configuration files have now been included in the
> linux-firmware-20241210 release and are making their way into the
> distros (e.g. Arch Linux ARM and Fedora now ship them).
> 
> Could we get this merged for 6.13-rc (and backported) so that Lenovo
> ThinkPad X13s users can finally enjoy excellent Bluetooth range? :)

This fix is still pending in your queue (I hope) and I was hoping you
would be able to get it into 6.13-rc. The reason, apart from this being
a crucial fix for users of this chipset, was also to avoid any conflicts
with the new "rampatch" firmware name feature (which will also
complicate backporting somewhat).

Those patches were resent on January 7 and have now been merged for 6.14
(presumably):

	https://lore.kernel.org/all/20250107092650.498154-1-quic_chejiang@quicinc.com/

How do we handle this? Can you still get this fix into 6.13 or is it
now, as I assume, too late for that?

Zijun, depending on Luiz' reply, can you look into rebasing on top of the
patches now queued for linux-next?

Johan

