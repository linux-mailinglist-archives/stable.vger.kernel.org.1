Return-Path: <stable+bounces-225297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMhMM8T8s2mWewAAu9opvQ
	(envelope-from <stable+bounces-225297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:02:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95A2829D8
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 471F2301B668
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D837B03D;
	Fri, 13 Mar 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FXHA9sHu"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC51DDC28;
	Fri, 13 Mar 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403317; cv=none; b=Frw8RLKTJN5gU+nU9tcEQPlBrhxt10APPmPK7wMfdzHOnC2+w0zBXFk82f/9z8GTfyqy2vFI+Ng6xAkQPb/xEX62cKqzi2WbrM4bsl7lPFcpE0E2rGFJFikmrqXtby4G3C1uSTMQqw9jSf7Z4NZE1xpSPvpqBFi4Z7bj5SdWfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403317; c=relaxed/simple;
	bh=klnlkVZW5ooK6rH93PXh5pZHgx2YTaJnnl4cniAe3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIxYcUyPnTbJLjJhVOXIQ765P2iA9H8g2WMGicxQe4yfUYJcX3IJyrr+ikaihr+stfrRAPNOhJGez/TyWPDHO9kLb3jJ3Xe2ETOUOPylB+XezxAAKUIA/rj2g7KWOcBUpAkCcIotrz2YNIFoMG1R4g0KPqnjrA3OaHz1RbVPh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FXHA9sHu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e/6Qya3g2Az9z6Fvg6kLMSVvcFkL/b4Ek7bHah/8dLM=; b=FXHA9sHul41Ys2QXs4Zu4NGtlX
	5faRTuDKmDL1l7vCJllr7BX0zVv/Er6w5Ve6/REzVZ8KfEM048h3Eyz0TJJ4N4bBfjUIOq1LuC27p
	27A2yReVgSJS4/gp2taA7v2nDVMniKpmR6NSdPikVNqhFsQi/T3lG5QgtGXO+/y8WL9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w11Cu-00BUPh-Nq; Fri, 13 Mar 2026 13:01:32 +0100
Date: Fri, 13 Mar 2026 13:01:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shruti Parab <shruti.parab@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
Message-ID: <be6c2fb6-1f34-4396-9b1d-3d1f156f3146@lunn.ch>
References: <SYBPR01MB7881338BC956C39A9848EE86AF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881338BC956C39A9848EE86AF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225297-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A95A2829D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2929,6 +2929,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
>  		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
>  		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
>  
> +		if (type >= BNXT_TRACE_MAX)
> +			goto async_event_process_exit;
>  		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);

Using ARRAY_SIZE(&bp->bs_trace) makes it clearer why you are doing the
check.

	Andrew


