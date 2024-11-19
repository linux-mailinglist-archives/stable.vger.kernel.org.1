Return-Path: <stable+bounces-93928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C929D2099
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA48282A8F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E42158D96;
	Tue, 19 Nov 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6OJmIk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46D154C17;
	Tue, 19 Nov 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000246; cv=none; b=Y7x5rHu+WI4zsci8ZT2cJgq1lnIf1K2zYSz1105R2WYOFxJDmvsdgREXSYbiZ01Fn6O4IZPxWXNmGH397Uf9EcZ2caf83leirw2veHnOn93lb8VK0OGkATdrTG4NLvkFJpKu1YjmKgmalGpTgERHBU2wDq1nzNyoS+jLeO4cqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000246; c=relaxed/simple;
	bh=shWx6Jcnj1KegI/uJvVbQm45B4OLMQ5bxRUZIgx+ohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECESZXyb91AclX3h/EgIJHY1KAeVebJkitnXlu5Eakht6SySQYwWUYH/DOIegmLLQG0H2wmppWgoTRYS+cbDlUkjvlJMpe6FFzeL2xjTdY2maOq6rmiHGac1v9Ubz/sDZJstpsIPAQsWJSWvQHHyv3JFnMoHPSwJxkLAoa9wUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6OJmIk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7BC4CECF;
	Tue, 19 Nov 2024 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732000245;
	bh=shWx6Jcnj1KegI/uJvVbQm45B4OLMQ5bxRUZIgx+ohM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6OJmIk7PIW+zmrq0G5sC5/mbeSlj8LW234oLQBUtfta87oICCg1hvZL/pnG8Kd+V
	 xwUBDmKlgPRKpnNT2iT6dtBAP/xTY1lV+jRao0ZEzs6Ol4b9xzVE4jz9hYcvRLmZcZ
	 Xld35W+z8Ov5tHMrGj0xa9PcU/sIyNB2efaI9DM6kMCNMmwBPW+fImbAxRayFPn5ll
	 kWxXSbHbsBz8qmfUTHp+trnfadLzWyRbHaAyabcT7Qqo8HblFLxnc+i/rGVjXp49DS
	 ZSpw+vOPVqqJu2rl1Bq/bNBiP1IKgTSL/jO6p7QtDhvK3UiezQV9+xYP2QdmoVwy0a
	 ePl5Wuzmf1/GA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tDINd-000000004L2-2Ya0;
	Tue, 19 Nov 2024 08:10:33 +0100
Date: Tue, 19 Nov 2024 08:10:33 +0100
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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
Message-ID: <Zzw56VwjTmlJ7mpW@hovoldconsulting.com>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
 <Zzs2b6y-DPY3v8ty@hovoldconsulting.com>
 <d382b377-e824-4728-8acd-784757dde210@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d382b377-e824-4728-8acd-784757dde210@quicinc.com>

On Tue, Nov 19, 2024 at 10:13:11AM +0800, quic_zijuhu wrote:
> On 11/18/2024 8:43 PM, Johan Hovold wrote:
> > On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
> >> For WCN6855, board ID specific NVM needs to be downloaded once board ID
> >> is available, but the default NVM is always downloaded currently, and
> >> the wrong NVM causes poor RF performance which effects user experience.
> >>
> >> Fix by downloading board ID specific NVM if board ID is available.

> >> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> >> Cc: stable@vger.kernel.org # 6.4
> >> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > When making non-trivial changes, like the addition of the fallback NVM
> > feature in v2, you should probably have dropped any previous Reviewed-by
> > tags.
> 
> make sense. will notice these aspects for further patches.
> 
> > The fallback handling looks good to me though (and also works as
> > expected).
> 
> so, is it okay to make this patch still keep tags given by you ?

Yes, it's fine to keep my Reviewed-by and Tested-by tags.

> >> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> >> Tested-by: Steev Klimaszewski <steev@kali.org>
> >> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> >> Changes in v2:
> >> - Correct subject and commit message
> >> - Temporarily add nvm fallback logic to speed up backport.
> >> — Add fix/stable tags as suggested by Luiz and Johan
> >> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com

> > If you think it's ok for people to continue using the wrong (default)
> > NVM file for a while still until their distros ship the board-specific
> > ones, then this looks good to me and should ease the transition:
> 
> yes. i think it is okay now.

Then I think this patch is ready to be merged.

Thanks again for your help with this.

Johan

