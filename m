Return-Path: <stable+bounces-83458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEB99A575
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977EF1F256F6
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEDB218D9A;
	Fri, 11 Oct 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdfuTpzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529412185B9;
	Fri, 11 Oct 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654770; cv=none; b=J6M+IHUEmeP7OrbCpQET2PRk6n8NVFJNh3Lho1mBJXmKtMQKjDIXFjxew0FPSgUftY92zGBwmACvKvBngR2xozYElE+Obgts/XzGEcRA7bZzzaxrf1ZkkcBHBIOo/hfPNGMEoEHHKy1HGTVq3Rp9tD6X85rXO5cjmus/sxPUyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654770; c=relaxed/simple;
	bh=YpimA8c5con0pxEYgdVuNfg3HKik8NZXlPfITZ9AJIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMyDlqnqgJJLla21NKlKf+axhcORUYk63RJihP4fYQqg1UBYw8q4Xkgg4+Ga9G2FPIGmtBWPxqqzUYY3rre/QgqYeNcHljIlzT64GcLiSeEimLblPMBcLBcGZTE82H6yZi5fQfm2BgGdzS51xS5CAdCeo8GnPxnVGak7Ee7fcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdfuTpzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33AEC4CECE;
	Fri, 11 Oct 2024 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728654769;
	bh=YpimA8c5con0pxEYgdVuNfg3HKik8NZXlPfITZ9AJIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdfuTpzC99Wu2IlCQBN0xUDH9VJORgNpbEqSQnpkaG7BExPTz63IgZYtQrl3v7I2k
	 qDN5NCRD3HmbRiBOOPVgj7ZIxECOHp104qFI0jtv7Yg8rFRGq2WgPBWBOG7btKdqlu
	 D224i9t/5ukkuQJunKIDlmnR1CNadf4MHBgFHcRfsr+1r8JxObLz7AhFad2Smiu8Tg
	 au69aw548N6DPjtYLOo0thE92VUu2WbZqGtATMDeJZVu2q07qGvRTSaX9RHd77Ndum
	 jMjL0fhx5pMmUyXCeTJjjJJjhXkiso+6ss0DzGs2ddNmJenKVIy8DYYpATVhj2XceI
	 6QPhkWem5Pwzw==
Date: Fri, 11 Oct 2024 09:52:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 030/139] l2tp: don't use tunnel socket
 sk_user_data in ppp procfs output
Message-ID: <ZwktsCI3Lsd0kaJq@sashalap>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <20240925121137.1307574-30-sashal@kernel.org>
 <20e00433-dc5c-74aa-6195-16281867dbb1@katalix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20e00433-dc5c-74aa-6195-16281867dbb1@katalix.com>

On Wed, Sep 25, 2024 at 03:27:23PM +0100, James Chapman wrote:
>On 25/09/2024 13:07, Sasha Levin wrote:
>>From: James Chapman <jchapman@katalix.com>
>>
>>[ Upstream commit eeb11209e000797d555aefd642e24ed6f4e70140 ]
>>
>>l2tp's ppp procfs output can be used to show internal state of
>>pppol2tp. It includes a 'user-data-ok' field, which is derived from
>>the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
>>being non-NULL to indicate this instead.
>>
>>Signed-off-by: James Chapman <jchapman@katalix.com>
>>Signed-off-by: Tom Parkin <tparkin@katalix.com>
>>Signed-off-by: David S. Miller <davem@davemloft.net>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  net/l2tp/l2tp_ppp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
>>index 6146e4e67bbb5..6ab8c47487161 100644
>>--- a/net/l2tp/l2tp_ppp.c
>>+++ b/net/l2tp/l2tp_ppp.c
>>@@ -1511,7 +1511,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
>>  	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
>>  		   tunnel->name,
>>-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
>>+		   tunnel->sock ? 'Y' : 'N',
>>  		   refcount_read(&tunnel->ref_count) - 1);
>>  	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
>>  		   0,
>
>This change isn't needed in 6.6. The commit was part of a series for 
>6.12 that removed use of sk_user_data in l2tp tunnel sockets.

I'll drop it, thanks!

-- 
Thanks,
Sasha

