Return-Path: <stable+bounces-235823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MLoFuek22ldEgkAu9opvQ
	(envelope-from <stable+bounces-235823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:57:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA753E4195
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103B130143C6
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B983033F5;
	Sun, 12 Apr 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svDDyImP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204782FFF8D;
	Sun, 12 Apr 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002269; cv=none; b=gCTzQvtDf63y46wzWpHmm1NuULBVMf21OlwfvSpSNQmxWydxJA6pjmC3Z74EOMiMeFfrN2lQDC4MelcPnvSuRHPu22a0tHZx9zgPjXjr1nItcjUTgB+7Pw1bgFCq8hNvY2VqX3gEwiPgSFqtu6Mhc9NfdxA3XGAMIYZYUP+m0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002269; c=relaxed/simple;
	bh=omA3b8cnvVduHXpR7xoDKK9/EF0M495B7bsB034M4LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3YIJpZd82JXTfEsj6KiT+Y3ak0U+LTQ+6wU0j2HMPtRduXXIZl3B0fCv+pdJ07yEsbNItf/F+Jx3aw8nT7p/NEdcjwmQRjrgt7N7VJ9j7Qb6x1rwsyXQxWyDp4E551rhHR37Y4d/n2NqSOAa7niX7sBZJMeQw3H/xjr+cNpZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svDDyImP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6DFC19424;
	Sun, 12 Apr 2026 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776002268;
	bh=omA3b8cnvVduHXpR7xoDKK9/EF0M495B7bsB034M4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svDDyImPczF6y2qdapLRapLEotgPw98OlHHirsGGM9Sb6TjUxtmBAbkPwtMXDgUoh
	 QyrB6DLH+edAIq1qi3xeISbu0RhbrKwIkqxgq5o3I4ILLk2OPpG1K/F6CXVabaxIdV
	 /Z+cnrvh+uuy7Fax36lhsfuJnjOL5upPdavGCcyhk+AgAx2hR01DyZmGfH0mXpbMBX
	 KKINIDvJsW0w73pb4DNFcIMZPBiwZbS42ugYT2TjfFNCreHkjJjO6BRSaD/PUDp8AZ
	 zUl507IjWJuKEyUy4DVkW4u7A7tuPULax3nrKUkN5V14nC1LuUriM5orNLADEyoL74
	 HBKfLGbTS+pJQ==
Date: Sun, 12 Apr 2026 14:57:43 +0100
From: Simon Horman <horms@kernel.org>
To: Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, kees@kernel.org, thorsten.blum@linux.dev,
	arnd@arndb.de, sjur.brandeland@stericsson.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
Message-ID: <20260412135743.GK469338@kernel.org>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408125333.38489-1-xiaoguai0992@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235823-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FA753E4195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 12:53:33PM +0000, Kangzheng Gu wrote:
> cfctrl_link_setup() copies the RFM volume name from a received control
> packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
> packet can omit the terminator and make the copy run past the 20-byte
> stack buffer.
> 
> Stop copying once the buffer is full and mark the frame as failed by
> setting CFCTRL_ERR_BIT so the link setup is rejected.
> 
> Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
> ---
>  v5:
>  - remove the Reported-by.
>  - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.
>  - using %zu to adapt the compilation of 32-bit kernel.
>  - add rate limit to error message
> 
>  net/caif/cfctrl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index c6cc2bfed65d..373ab1dc67a7 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
>  		cp = (u8 *) linkparam.u.rfm.volume;
>  		for (tmp = cfpkt_extr_head_u8(pkt);
>  		     cfpkt_more(pkt) && tmp != '\0';
> -		     tmp = cfpkt_extr_head_u8(pkt))
> +		     tmp = cfpkt_extr_head_u8(pkt)) {
> +			if (cp >= (u8 *)linkparam.u.rfm.volume +
> +			    sizeof(linkparam.u.rfm.volume) - 1) {
> +				pr_warn_ratelimited("Request reject, volume name length exceeds %zu\n",
> +						    sizeof(linkparam.u.rfm.volume));
> +				cmdrsp |= CFCTRL_ERR_BIT;
> +				break;
> +			}
>  			*cp++ = tmp;
> +		}
>  		*cp = '\0';
>  
>  		if (CFCTRL_ERR_BIT & cmdrsp)

I am wondering if it would be best to follow the pattern for
writing linkparam.u.utility.name elsewhere in this function.
That:
1. Uses a somewhat more succinct loop control structure
2. Silently truncates input without updating cmdrsp if overrun would occur

Something like this (compile tested only!):

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..ba184c11386e 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -15,6 +15,7 @@
 #include <net/caif/cfctrl.h>
 
 #define container_obj(layr) container_of(layr, struct cfctrl, serv.layer)
+#define RFM_VOLUME_LEN 20
 #define UTILITY_NAME_LENGTH 16
 #define CFPKT_CTRL_PKT_LEN 20
 
@@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		 */
 		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
 		cp = (u8 *) linkparam.u.rfm.volume;
-		for (tmp = cfpkt_extr_head_u8(pkt);
-		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		caif_assert(sizeof(linkparam.u.rfm.volume) >= RFM_VOLUME_LEN);
+		for(i = 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i++) {
+			tmp = cfpkt_extr_head_u8(pkt);
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)

Also, it seems that writing linkparam.u.utility.paramlen elsewhere
in this function also has a potential buffer overrun (by one byte).

