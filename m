Return-Path: <stable+bounces-227228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAZuGU6wu2lymgIAu9opvQ
	(envelope-from <stable+bounces-227228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:14:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077112C7B77
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87703050D7C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4B3A782A;
	Thu, 19 Mar 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YVyFL6qX"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB52D8387;
	Thu, 19 Mar 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907829; cv=none; b=tLO/TVWw5AxNeqKzoBhJEFBrNJ7lILhMJc83WGlu+hMEBdcxysR39Kz2dVBgKr6zt9LAnoHOWy8CLauDjSHwQtWroCZ/+kxNkzO1iffMmajyYrIBT8LMRKkr6gs9R+DEKKroHXArkMCIOVlsqKXZc4e3xXnJqqW0/ikwpj75r14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907829; c=relaxed/simple;
	bh=i1MplFUyxsvEK5l5FSuDZ60akTYTlhJg16q7unREk8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4Gktwjr7DA5v9isKfxAXSr7tQZgiH401z4nUOYiIzTCuc7Zly2h8F8aMl6iYAsud7wRxneQtx5koSJOhblNVepkgNJ51OsKqbT1YR6OZNpFlvkXlcNS0eY4VJeppZnVYQsAs7daQYlEvTQldPf71dLgRGgITpQAA5JA8TO39b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YVyFL6qX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5C9D520861;
	Thu, 19 Mar 2026 09:10:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBO-I0WzpA8n; Thu, 19 Mar 2026 09:10:17 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 91F0220868;
	Thu, 19 Mar 2026 09:10:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 91F0220868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773907817;
	bh=TGv6/dFlxMtmA9Tj4pcrk8erMHgmDIkxWr0O6oTmkY4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YVyFL6qXcFPwp+sTi0UbGm2OjtpdBzwJyGU1Vl/7D6Qbsz1VkE2JfpxF2+FPQlBxm
	 0WX0TnVCUweWAkfeapcWSxsOBSMvZiR1YI22gdDbgaDb/mlesSf46YCV+sS9U4ZgQp
	 7mnTfBddTBbYRzA80JRiJHz13ghlJC5q/ud2P6HCUP8oodmDa+uegJaqLtKctgFWL+
	 ZG33FHexPVzDTg1zNNOjYxKI8XcbBT3U4BA0BlOXLg8u9+rqMhUQ3KA8tduLV2T7d9
	 5hy1aCojQw/vox7f4qwhXfOxaIo0ZnlO4WaxukRWe5yhM71YjSLemKI+nVcLira8Tf
	 2/qwHVmEVTuIw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 09:10:16 +0100
Received: (nullmailer pid 2712056 invoked by uid 1000);
	Thu, 19 Mar 2026 08:10:16 -0000
Date: Thu, 19 Mar 2026 09:10:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moses <p@1g4.org>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <chopps@labn.net>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] xfrm: iptfs: only publish mode_data after clone
 setup
Message-ID: <abuvaGsLdlxOhXzh@secunet.com>
References: <20260316145642.4154656-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260316145642.4154656-1-p@1g4.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 077112C7B77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 02:56:51PM +0000, Paul Moses wrote:
> iptfs_clone_state() stores x->mode_data before allocating the reorder
> window. If that allocation fails, the code frees the cloned state and
> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> 
> The xfrm clone unwind later runs destroy_state() through x->mode_data,
> so the failed clone path tears down IPTFS state that clone_state()
> already freed.
> 
> Keep the cloned IPTFS state private until all allocations succeed so
> failed clones leave x->mode_data unset. The destroy path already
> handles a NULL mode_data pointer.
> 
> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Applied, thanks a lot!

