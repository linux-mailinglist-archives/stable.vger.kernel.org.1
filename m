Return-Path: <stable+bounces-224648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIEkGqkbsWmOqwIAu9opvQ
	(envelope-from <stable+bounces-224648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:37:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBFE25E0B1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 910C53008D1E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E83B2FC9;
	Wed, 11 Mar 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtvHdUfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04A3AF650;
	Wed, 11 Mar 2026 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214626; cv=none; b=Ptci9RP6hoPECIvmQAXY1m1bg5+QR+LV/xlXL/N98ot/vv5wMEU2EZViSNLpEhJmiUiEUKklAMYQQWdvz9d+1JdmFjNicmjSUyI5GBPlBoheKpsiNfAbCRcMdNJZILvLpr8MMa8rQzAx5H4btgnd5PKlKTFkLylb2aQ6tU/PIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214626; c=relaxed/simple;
	bh=DlTWqEYmmaHPY7LRtbKDsD5+DzQ07gnLXptRGHY7zvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nQ9/2twzq9gS2TGXpC8Bxo84cxohRE9cuKAc4/QyrRxTivcIi7WlaUxPkok4exidILoQRageJtWYQdsjZZ6Z4fKqcemllygxSknheeZf2wBCqsHjNQuz5z/30StF3LmMgK94R50aDhDgKJgLqYlPt9SDAIblhqkTv7XylAincQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtvHdUfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FA7C4CEF7;
	Wed, 11 Mar 2026 07:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773214625;
	bh=DlTWqEYmmaHPY7LRtbKDsD5+DzQ07gnLXptRGHY7zvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YtvHdUfPDH4V8eGv4CAkFIjWXX5VyY/FPveZNpN3uHpRsvTBzGF/nOoV15oF6Pzd6
	 Ev7qM6Hd8j8lxjKBGAxFh3qy907xZRURTPrpMK0MoqmECQAVSybnK5JVJqZKtYfiDp
	 is5t3/udqQ8OsUB/8mmivaxN4yG1+cJwS60lIbDGb/D9zNDZbEkw1NQW0MBGlHZbwG
	 ayzjuJ4ADWE7NaxKzN87/c+IQZ1vhmnVXnDKCJ2dPds4gS2TpGPAB01OJ3dGmtPEJl
	 gMkq9/jKCOK67BU+uTF3Npnpl6H6F4An2RiH/kCCLXJKRpYgG7LXOHabyu++cn8YVH
	 ENTk057UPGh1g==
From: Srinivas Kandagatla <srini@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>, 
 stable@vger.kernel.org
In-Reply-To: <20260306142235.1401319-1-festevam@gmail.com>
References: <20260306142235.1401319-1-festevam@gmail.com>
Subject: Re: [PATCH] nvmem: imx: assign nvmem_cell_info::raw_len
Message-Id: <177321462464.2138451.16844523641384766454.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 07:37:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: DEBFE25E0B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	TAGGED_FROM(0.00)[bounces-224648-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.226.201:received];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Fri, 06 Mar 2026 11:22:35 -0300, Fabio Estevam wrote:
> Avoid getting error messages at startup like the following on i.MX6ULL:
> 
> nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
> nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
> 
> This shouldn't cause any functional change as this alignment would
> otherwise be done in nvmem_cell_info_to_nvmem_cell_entry_nodup().
> 
> [...]

Applied, thanks!

[1/1] nvmem: imx: assign nvmem_cell_info::raw_len
      commit: 70557835f9d310767e1af4522af59ad0aadc1ce1

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


