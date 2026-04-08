Return-Path: <stable+bounces-233930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HXeG6ts1mkQFQgAu9opvQ
	(envelope-from <stable+bounces-233930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:56:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0D3BDE72
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4CCA30137AB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69AF3AE19D;
	Wed,  8 Apr 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD0EqBeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65B335063
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660200; cv=none; b=ej6zGWpjwV59ZwCY1gqEGT2sCuF2f7ALrly0YhYKzu7cvC/0G8y1B+IRhypiNX0W9Uf4E2lxHjr57sf5rWIv7xyB5PynxlfBy0YvvotCIYoc8eYps3HATSMNUsP6atm7c8VIfC7kmoffigaspkNFpwLaAUFvti0/c12J6i5MNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660200; c=relaxed/simple;
	bh=qYsnazDF4OoiAR9l8ZuuySpQqBpQcaDh73wigPitlE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZx5wAE9aGB0YB+hp0RHUPfId1vSm4u8+qgTo7jMaCu6NRun5B6Z6aAYb+nkULCMulE2tht8hBtE9uA35TPIi2M0yVdprEnipVSxBCRxFv31lHq69r+YE27Dsi3fEmB5lP9RzzuRZ21aoEBe1o2Njn/N0ZyARw+3/mgniwEdpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD0EqBeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F79CC19421;
	Wed,  8 Apr 2026 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775660200;
	bh=qYsnazDF4OoiAR9l8ZuuySpQqBpQcaDh73wigPitlE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VD0EqBeoMo15XB2yIaxoI9h7CQx7+7BQCuDsuqgf3ETd9PR/n8IPQnSbNzL59JFL6
	 IJHWOZ6FRLaUY1Hn/VN3s9N61vz9sOwE1BFW+cB3GVDFPEhzpOi2LkjNYcUET2O4up
	 oyLh01sn4mmiT514InldeSqCTqtjhQtSyYDJW0tZE7XKyAJV+4urlWmbMb02ghsrZ2
	 grCHKWevQnp5gDL9mbHyEOs3z7fiEuGq+FEnxHmKNg13WLUwAqBK2MpU+WYCUSULjj
	 9yKTKinrWIc0/NFO+Nt73QEMmxuiHl5bHU9FVrjjnUDh0tCrFyNKBk0GEz2D7yu+kX
	 D9KEjUSZV1WQA==
Date: Wed, 8 Apr 2026 10:56:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <adZspiOMwT6nsVIf@laps>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260408104825-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260408104825-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233930-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F0D3BDE72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:48:57AM -0400, Michael S. Tsirkin wrote:
>Srujana,
>
>
>do you want to do the stable backport yourself?

Please feel free to ignore my backport, I was just trying to keep it minimal.

-- 
Thanks,
Sasha

