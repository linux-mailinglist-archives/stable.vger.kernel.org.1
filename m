Return-Path: <stable+bounces-212931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGY5JpqdfWmYSwIAu9opvQ
	(envelope-from <stable+bounces-212931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:13:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE100C0EEC
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23ED300CE62
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4D31C57B;
	Sat, 31 Jan 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="XBgenLn4"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA731BCA9
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769839997; cv=none; b=HWgAPZGiXcq4SMktIH39ruLyleRulM+4/TX8HPlyU9hXu8ijmQ50xTXq1hxe6FstWZtYQ+c75KP+IKWGHEHCctre/xP8+mlXfIpx/N4S5UaxEp3AYo5cwm+8bXvkIyT5gMzNhuad2ayYMuZLWbrXKywLY1icxVufhZ9J3GA456o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769839997; c=relaxed/simple;
	bh=S5QS4QrBbXd53iVDxcnbSBS2H6BGQcxYOTrLN2xJWdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpe9h0IaQ1IAR9qcavX+VluzZyJs6dJe2isPaGBbLezUBvm8LzjmqDWa9YzMTPjfAurntsLmQ0v72TrzIx/RpMGAfwriIBxbpGeSFtsftJYPf+PeRe+0v/HlSaQWulcc9Vvz1942j5KwiKVAYrGk6BgAyFOZ+VC+UtAFlZOl8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=XBgenLn4; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60V6D4tN072210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 31 Jan 2026 15:13:05 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=vpaHteD97DiVFaAs0Ate1NmbUcN7m/ErCU3DJJSYNzQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769839987; v=1;
        b=XBgenLn4wgnJ1zMAW/kbmMJyhALGrl1AWnKI5gzGzCR0l8i9KZbBLIDcu0tePkHc
         rOGF0PSUBXIVaYHmG/9n4d3faCODXk0AA2ogUrazk3Gzn+9EN0tWrhG+eOUTzLlK
         wpuUpzN6Xn3XtwUW29KXyLQ5JX0nTvYOAzgXSLHlEZ7Pw9vceAjcbwZyIX5/dLag
         95lbE4NuAlvETCjmWsU+yPEYbKa2gv5EwzWwbzu1LLdw/yxbCYuOo3yP/QmpnYi8
         H+tr4Wwf4t+WC0tytEuU9K04OYW/0QntG0I9yG3Lu1xE64Q6hieIvZjI4d+1FbQ9
         BKYHYasNAQrt8K6nJmEzRw==
From: Kohei Enju <kohei@enjuk.jp>
To: lihaoxiang@isrc.iscas.ac.cn
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, bjorn@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
Date: Sat, 31 Jan 2026 06:12:12 +0000
Message-ID: <20260131061304.27368-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
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
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212931-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE100C0EEC
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 13:52:17 +0800, Haoxiang Li wrote:

> In i40e_xsk_pool_enable(), add an error handling path to
> prevent potential memory leaks.
> 
> Fixes: 1742b3d52869 ("xsk: i40e: ice: ixgbe: mlx5: Pass buffer pool to driver instead of umem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
> - Add a Fixes tag. Thanks, Paul!
> - Replace unmap with i40e_xsk_pool_disable() to prevent
> a limbo state of queues. Thanks, Maciej! 
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..a72a309540c3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -108,23 +108,26 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
>  	if (if_running) {
>  		err = i40e_queue_pair_disable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		err = i40e_queue_pair_enable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		/* Kick start the NAPI context so that receiving will start */
>  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
>  		if (err)
> -			return err;
> +			goto err_out;
>  	}
>  
>  	return 0;
> +
> +err_out:
> +	i40e_xsk_pool_disable(vsi, qid);

I think return err; is missing...

Also, since i40e_xsk_pool_disable is not declared before this line,
compilation fails due to a 'Call to undeclared function
i40e_xsk_pool_disable' error. Adding declaration or moving
i40e_xsk_pool_enable() after i40e_xsk_pool_disable() is needed.

>  }
>  
>  /**
> -- 
> 2.25.1

