Return-Path: <stable+bounces-212933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ucDuEVGpfWlZTAIAu9opvQ
	(envelope-from <stable+bounces-212933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 08:03:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D97C1081
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 08:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4D93009B26
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6A26A1CF;
	Sat, 31 Jan 2026 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="DFLkZzag"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3335D8F0
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769843020; cv=none; b=iWI6qTMT1b1DcibuhwBHTXpgA7bVHrTtDuK5GURXbwsCCZHUMySDfv1hC9TynWaPB4nTM7J5uR+S3aDCKN9BGggZi1HpqKxE3+xcIenR6n0l187mVM1cO5HbPCPX7WtlnxnXLNPRRMpJOyAb4LDsHXTgSIwmrgY5uhfRpna5aY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769843020; c=relaxed/simple;
	bh=6EWdvGFMeGOZ3ybmMF54CEgrpRbcZjIC0e7KxtUYD1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZrEd1s942qt37h5z9me01LFDAkgK4g6j2T0KEBOu1jbmWKYKWy4L6GuaGneKSS4Ly1dJ3XfCh2axrpJ8XWgaOCEjbpMJO6tT3UESFR09orL3BknAip4iqVkA811gx3XGHNzpwGrClYYp7TQ8D/X6aGXVAJ59tDwY87mlB8kvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=DFLkZzag; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60V73ZSS013433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 31 Jan 2026 16:03:36 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=9+22T3qAILLWnarXKk2rk2jH9okIYXXwV2PNBFUkk50=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769843017; v=1;
        b=DFLkZzagAsrFRi53NMETPhbWhcFfg4o9hcQnuMUXLA+1j4H5WwvOjBmv9eykxz5T
         jW4UkQWDIv0yMUtX7cCJmimqaWrj4WIBnkAI92WdByrBv4TyXcH8m9t10KgRqlPZ
         gehnhZxXZZGTayYdVsFSyM1NRhDOFiHR4/lSqYNWNjwhiytG9SSnXes38QxL7qDS
         obF5Rs+DGcWrwMzi+cR8+pBgExZOKFVCiSP2D/2wELUankdMn2dKpSDiLbQQEFls
         1dQlmUkmdZG0t+sMc+C3AqruS/u9w9a7hT4mBomgbSaG7+5EheuasQ4ZAW//4dQU
         ofR8nH7F98rogpqaFEHOLg==
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, bjorn@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        lihaoxiang@isrc.iscas.ac.cn, linux-kernel@vger.kernel.org,
        magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
Date: Sat, 31 Jan 2026 07:02:38 +0000
Message-ID: <20260131070335.38303-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131061304.27368-1-kohei@enjuk.jp>
References: <20260131061304.27368-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-212933-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90D97C1081
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 06:12:12 +0000, Kohei Enju wrote:

> On Sat, 31 Jan 2026 13:52:17 +0800, Haoxiang Li wrote:
> 
> > In i40e_xsk_pool_enable(), add an error handling path to
> > prevent potential memory leaks.
> > 
> > Fixes: 1742b3d52869 ("xsk: i40e: ice: ixgbe: mlx5: Pass buffer pool to driver instead of umem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> > ---
> > Changes in v2:
> > - Add a Fixes tag. Thanks, Paul!
> > - Replace unmap with i40e_xsk_pool_disable() to prevent
> > a limbo state of queues. Thanks, Maciej! 
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..a72a309540c3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -108,23 +108,26 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
> >  	if (if_running) {
> >  		err = i40e_queue_pair_disable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_queue_pair_enable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		/* Kick start the NAPI context so that receiving will start */
> >  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  	}
> >  
> >  	return 0;
> > +
> > +err_out:
> > +	i40e_xsk_pool_disable(vsi, qid);
> 
> I think return err; is missing...
> 
> Also, since i40e_xsk_pool_disable is not declared before this line,
> compilation fails due to a 'Call to undeclared function
> i40e_xsk_pool_disable' error. Adding declaration or moving
> i40e_xsk_pool_enable() after i40e_xsk_pool_disable() is needed.

After skimming the code, I think i40e_xsk_pool_disable() can fail in
this error path, right? 

Let's assume a scenario that i40e_queue_pair_disable() succeeds but
i40e_realloc_rx_xdp_bi() fails in i40e_xsk_pool_enable(). 
At this point, i40e_enter_busy_conf() called by
i40e_queue_pair_disable() has set __I40E_CONFIG_BUSY state.

Then the err_out: path is executed and i40e_xsk_pool_disable() tries to
call i40e_queue_pair_disable() when if_running.
In this case, i40e_enter_busy_conf() fails because __I40E_CONFIG_BUSY is
set, and finally xsk_pool_dma_unmap() isn't called.

Do you have any thoughts on how to handle this case?

Thanks.

> 
> >  }
> >  
> >  /**
> > -- 
> > 2.25.1

