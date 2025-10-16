Return-Path: <stable+bounces-186085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F5EBE38A5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC78483BE3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EEA33438E;
	Thu, 16 Oct 2025 12:56:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFB334388;
	Thu, 16 Oct 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619415; cv=none; b=Bhj1yrjqna3a0c/Y5odEQrlZRlWg+6HOU05wlo+77ZbbDAfKixoXELfQjlKNf5GIuJHLKq3FHTX6SaRe7HBk4WzexCVRoI+PasrDC9TLbZ31xJ3NM+3LDIo2Kaq6PVJk4FG8fYI9XyUSTZrBN46ipEr8AaQXd/Z9hdWr5W0l5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619415; c=relaxed/simple;
	bh=QCOyN6KuJ4hFzNjqlg0JXPAekV06BTnAMfsrHKk/wtQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=asucOHyt90e27Uj8vl+H9RHfakpenZz9adYw5yRiV7d1000ipzguaAGTtVg0BrW8YKUd7QkpwFGEvHXbt2sRfZUN+D4Px3BEmD5KLQT27TVEtEI/Mx/4PID9skpDqzPQ2nRjUaVaK81WzvxMG42fAwNAs0aPEzrYudRJuuy1Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1760619392tc3c82dbd
X-QQ-Originating-IP: cnEtqtuHWAKijmXNbJTnEQzRBjJEfjMOSEzmfw9hv30=
Received: from smtpclient.apple ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 20:56:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3397144977975772074
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] net: bonding: update the slave array for broadcast mode
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aPCH0vHFqHmBQY_i@fedora>
Date: Thu, 16 Oct 2025 20:56:19 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18630C3F-88B0-4A28-BFE7-D53BCDD8F255@bamaicloud.com>
References: <20251015125808.53728-1-tonghao@bamaicloud.com>
 <aPCH0vHFqHmBQY_i@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N4WhQbLQyIqS/FP5P+ed85p1fKz5BQaT0di49oWcjstCUJEU8mpZQT/2
	CBt1sjyPjX4HIf5qTKZ3uxKwbW8V9k66O+pUiI0apsMVcNBnKoCVYMkBXZIbQnhlcWdM14P
	/fVBO8Ag5R1Z5qEhNkZzLuIuCnR908JqteFfL9xL/7PQvHWYw5oP6hA+hyXnQikAi3yp/6n
	m8gSD6zNAwVy7uC/Q5LYhvOSiDsEFY9bQM9RWv9mecSVT6h1YmdbtENpASywO9vJhhM8lik
	JcwwW49HnCXTRvL9L59KwFjXZGCNuopIk2HMZ23ZhPKYVMAtQWj5yN2G+kr9hySG4OalJI8
	FTbiwOLWk51SsGg1Hi+TlLO8nUDi3qdCosW7etVPbXGaJTIOWjey0EjmRQYNQgDxxNk1Sxf
	A2/bqGTlC+umJOizjCfTRYRlKxzI2EqbgRK0aYsZTE2wBygoNo90SdtDNK1dIHV2/OfOfG0
	TTvLBiqNr/xEurTqfAyA5EBRah/2cI0XYXXPMwFALA4iOiUB0Ey7ah/4wJjL/ODXmiTsCau
	//ri9ty4nzAZzetX2ByhDUJdfa6e57WXnoGanF8mOJE9JFCKyXYMqXOzKBJYB2x/uiJZ+u3
	3PK7ln8Nl0EMBVuOy6O4Z8PHc4TxzBjTl+KvSVpZmVz0Ns+dPT1uX5bPhwCzVllJfkL/kT3
	PAdam/9XorMhvIOrwNSaCLGKhJRE17ka5WSA+Nvt+9F/at42GQID1WlvAZGvfqoz0gj4ELU
	e2w7jIzn1Aztxtjr6K3kiNzKdNotEIvosfvpBSg6Mwi0PVSM1qObqe2zh9VBMM55GIG2INj
	RMjmC8/DnlT2vauRdHIuFNAzuoziMl5tXFFnozVYpflR/liwBc2aNT+PZfr+u/vz1gYBVNo
	EtFscbPukxO572seiPxLUY+kfTAFH9svY3+uVCwUMCUuPkyvQ3lBOB5uyu2tUU5deBXsFZ8
	XWhOUYu+K7ZYa7sZxdBGmxULtlzZRard0ShpzSWbossDU9XSJn9LCW38nBFTtZ1NWduOzm6
	lzypkKVQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> On Oct 16, 2025, at 13:51, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> Hi Tonghao,
>=20
> Please add the target repo in the subject. e.g.
>=20
> [PATCH net] net: bonding: update the slave array for broadcast mode
V2 is post with target repo and fix typo in comment.
Thanks.
>=20
> The patch looks good to me.
>=20
> On Wed, Oct 15, 2025 at 08:58:08PM +0800, Tonghao Zhang wrote:
>> This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor =
option for 802.3ad").
>> Before this commit, on the broadcast mode, all devices were traversed =
using the
>> bond_for_each_slave_rcu. This patch supports traversing devices by =
using all_slaves.
>> Therefore, we need to update the slave array when enslave or release =
salve.
>>=20
>> Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for =
802.3ad")
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> drivers/net/bonding/bond_main.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 17c7542be6a5..2d6883296e32 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, =
struct net_device *slave_dev,
>> unblock_netpoll_tx();
>> }
>>=20
>> - if (bond_mode_can_use_xmit_hash(bond))
>> + /* broadcast mode uses the all_slaves to loop through slaves. */
>> + if (bond_mode_can_use_xmit_hash(bond) ||
>> +    BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
>> bond_update_slave_arr(bond, NULL);
>>=20
>> if (!slave_dev->netdev_ops->ndo_bpf ||
>> @@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device =
*bond_dev,
>>=20
>> bond_upper_dev_unlink(bond, slave);
>>=20
>> - if (bond_mode_can_use_xmit_hash(bond))
>> + if (bond_mode_can_use_xmit_hash(bond) ||
>> +    BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
>> bond_update_slave_arr(bond, slave);
>>=20
>> slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
>> --=20
>> 2.34.1
>>=20
>=20
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>=20


