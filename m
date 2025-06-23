Return-Path: <stable+bounces-155313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C57AE37D2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946F0188AB40
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99A1FE470;
	Mon, 23 Jun 2025 08:07:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AD13AA2A;
	Mon, 23 Jun 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666021; cv=none; b=FEEhy7ZpzH87idMhFi5Hu2XfDVaGdMEHaqGDK6kjkt0dGjYoPQJ9zTyTyew++BqPA5yiNgzZ/jGCsCltBG6p+ZWkgXiqH1qdMGGikPZjSu6feC19CqlDDpp4aBhcUMS3o8nn7O9iqtxbJursigeDu2aNdqzmyxf+kYkH9DlVgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666021; c=relaxed/simple;
	bh=slUosbG7yshdLRqLoYxSJJK3hkZd4euJJSsD+wif5Ac=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukU8ngycIrZWpSG6g6wFWADZsW/L7lMHDLnWGr0PNNIZIBisFSQhcoQQPHDFj9eUlllPcjrCkV+2CKSXFLOfCQw0EnY+KJ4f/tosdtrNfaduNNHVVAUwyVkBF1wt4mpcl/Ieel+NHaIi9m6l7wcKFCNv3bW4zGTRvrRJfhO2AUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz6t1750665943tcb082e60
X-QQ-Originating-IP: l91o20o7EVFQEDCzBSLHnVQE/JuZXNOSH8VKBtYu3aw=
Received: from smtpclient.apple ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 16:05:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8770772394141310278
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net 2/2] net: wangxun: revert the adjustment of the IRQ
 vector sequence
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250620085720.33924-3-jiawenwu@trustnetic.com>
Date: Mon, 23 Jun 2025 16:05:30 +0800
Cc: netdev@vger.kernel.org,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 duanqiangwen@net-swift.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C50076FF-334C-4414-BC9D-878B68E7520B@net-swift.com>
References: <20250620085720.33924-1-jiawenwu@trustnetic.com>
 <20250620085720.33924-3-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OE2BWzPe+8Gt7csuAkMFfeByPaEzb8cBIEPQcvTVdmxmamKQr+1EaOVg
	c/Fkm0z/fdJiFXj5TQu7DaEQHoVrZoI/C/+mkDwyLYLyIR4xriMQZRMbFk7gdBYrgMAgnqs
	wDRUb2/kHOFCkghcdgA4f7kobLBMLJOH52LTZw4NiI2jRm8l+PMqvgrpMcvgktbJZ6DBpUP
	B4lAAYxaBEx47iJo3bb4GqFqMvP6SjkaegA7oNVPwdORyI/9PQtbHRU8gWntsb3pQmlGJrG
	vlVuSvoSW1N2PJrOarOKpFMlWXkANKKE+YZiNUfVHgM0SIop2C/n23/jayNRGPlXeVsIOz7
	Dt5cIOg9S/riljFysdXwje8tmD10tZMiNFBNCtfq2NHoK/1mNvgx8SODzk3l0C8JVa+iIF3
	LcihykY34xYBDzB198gL+HiIYJaRk8ksNLrzaFVuO71IqvwCQq3S/ooQ05EI6XE8kLLrzay
	ekwceikFwGvBs5aNWHbKRGFs15avBcKdKHrTXN+o0bLhWTOl08zUC4/EUlFVMzSl0K4xIYC
	1iPxWf2+P+KkmKnQYfny6WUcBbnqACtxYyDz1mqwX5skz57+ImgZJ9xBPFshJHWzYQYkJX5
	r3xgLQTZcxZvekuzjDnL4KF1Co4/+z3Dxqj7kGKO7I+xhc40V4x4kqD4cC+1JZVuUMczWcZ
	LYOf/Ucge3pe6pyb8OnIG49lVVOIer5DFWdtDyS9vm8fA8qjr/t8p4I6dul+/B0mwB/jLYy
	4Vy2Gwzur1t996/qALWZKSCEc1g4lKOdKW2KssHvEToNkz3PQ/OPablZacUa1WnJ/apMCcb
	q0yr4TAauoleRV7g8PdjmcuFwDq+mn/ALnFgsDn4K9fOiZogffC8DUmIOD0Qp8nK3dZ9QE2
	herl8gjgZwD4JE7aLl9Fn7T7RZMX/I8jVyRIoIdyJz5M8OPMGcogw8vJxn0hSY1F7vCGRR3
	VvuwSMwlhr0CHuLO+yJIjdml7bIF2zW7o5qFXkrRYADO/hp9upX0tXS0r+Lkm+3yr6SA2bs
	AopxtR67FBQhZ3QmCr
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8820=E6=97=A5 16:57=EF=BC=8CJiawen Wu =
<jiawenwu@trustnetic.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Due to hardware limitations of NGBE, queue IRQs can only be requested
> on vector 0 to 7. When the number of queues is set to the maximum 8,
> the PCI IRQ vectors are allocated from 0 to 8. The vector 0 is used by
> MISC interrupt, and althrough the vector 8 is used by queue interrupt,
> it is unable to receive packets. This will cause some packets to be
> dropped when RSS is enabled and they are assigned to queue 8.
>=20
> So revert the adjustment of the MISC IRQ location, to make it be the
> last one in IRQ vectors.
>=20
> Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel =
number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 17 ++++++++---------
> drivers/net/ethernet/wangxun/libwx/wx_type.h    |  2 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  2 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   |  2 +-
> drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c  |  6 +++---
> drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  4 ++--
> 6 files changed, 16 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 7f2e6cddfeb1..66eaf5446115 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1746,7 +1746,7 @@ static void wx_set_num_queues(struct wx *wx)
>  */
> static int wx_acquire_msix_vectors(struct wx *wx)
> {
> - struct irq_affinity affd =3D { .pre_vectors =3D 1 };
> + struct irq_affinity affd =3D { .post_vectors =3D 1 };
> int nvecs, i;
>=20
> /* We start by asking for one vector per queue pair */
> @@ -1783,16 +1783,17 @@ static int wx_acquire_msix_vectors(struct wx =
*wx)
> return nvecs;
> }
>=20
> - wx->msix_entry->entry =3D 0;
> - wx->msix_entry->vector =3D pci_irq_vector(wx->pdev, 0);
> nvecs -=3D 1;
> for (i =3D 0; i < nvecs; i++) {
> wx->msix_q_entries[i].entry =3D i;
> - wx->msix_q_entries[i].vector =3D pci_irq_vector(wx->pdev, i + 1);
> + wx->msix_q_entries[i].vector =3D pci_irq_vector(wx->pdev, i);
> }
>=20
> wx->num_q_vectors =3D nvecs;
>=20
> + wx->msix_entry->entry =3D nvecs;
> + wx->msix_entry->vector =3D pci_irq_vector(wx->pdev, nvecs);
> +
> return 0;
> }
>=20
> @@ -2299,8 +2300,6 @@ static void wx_set_ivar(struct wx *wx, s8 =
direction,


> if ((wx->mac.type =3D=3D wx_mac_em && wx->num_vfs =3D=3D 7))
Misc and queue should reuse vector[0]

> wr32(wx, WX_PX_MISC_IVAR, ivar);
> } else {
> /* tx or rx causes */
> - if (!(wx->mac.type =3D=3D wx_mac_em && wx->num_vfs =3D=3D 7))
> - msix_vector +=3D 1; /* offset for queue vectors */
> msix_vector |=3D WX_PX_IVAR_ALLOC_VAL;
> index =3D ((16 * (queue & 1)) + (8 * direction));
> ivar =3D rd32(wx, WX_PX_IVAR(queue >> 1));
> @@ -2339,7 +2338,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
>=20
> itr_reg |=3D WX_PX_ITR_CNT_WDIS;
>=20
> - wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
> + wr32(wx, WX_PX_ITR(v_idx), itr_reg);
> }
>=20
> /**
> @@ -2392,9 +2391,9 @@ void wx_configure_vectors(struct wx *wx)
> wx_write_eitr(q_vector);
> }
>=20
> - wx_set_ivar(wx, -1, 0, 0);
> + wx_set_ivar(wx, -1, 0, v_idx);
> if (pdev->msix_enabled)
> - wr32(wx, WX_PX_ITR(0), 1950);
> + wr32(wx, WX_PX_ITR(v_idx), 1950);
> }
> EXPORT_SYMBOL(wx_configure_vectors);
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h =
b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 7730c9fc3e02..d392394791b3 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1343,7 +1343,7 @@ struct wx {
> };
>=20
> #define WX_INTR_ALL (~0ULL)
> -#define WX_INTR_Q(i) BIT((i) + 1)
> +#define WX_INTR_Q(i) BIT((i))
>=20
> /* register operations */
> #define wr32(a, reg, value) writel((value), ((a)->hw_addr + (reg)))
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index b5022c49dc5e..68415a7ef12f 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -161,7 +161,7 @@ static void ngbe_irq_enable(struct wx *wx, bool =
queues)
> if (queues)
> wx_intr_enable(wx, NGBE_INTR_ALL);
> else
> - wx_intr_enable(wx, NGBE_INTR_MISC);
> + wx_intr_enable(wx, NGBE_INTR_MISC(wx));
> }
>=20
> /**
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index bb74263f0498..6eca6de475f7 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -87,7 +87,7 @@
> #define NGBE_PX_MISC_IC_TIMESYNC BIT(11) /* time sync */
>=20
> #define NGBE_INTR_ALL 0x1FF
> -#define NGBE_INTR_MISC BIT(0)
> +#define NGBE_INTR_MISC(A) BIT((A)->num_q_vectors)
>=20
> #define NGBE_PHY_CONFIG(reg_offset) (0x14000 + ((reg_offset) * 4))
> #define NGBE_CFG_LAN_SPEED 0x14440
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index 20b9a28bcb55..21fc86ec25ce 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -31,7 +31,7 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
> wr32(wx, WX_PX_MISC_IEN, misc_ien);
>=20
> /* unmask interrupt */
> - wx_intr_enable(wx, TXGBE_INTR_MISC);
> + wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> if (queues)
> wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
> }
> @@ -132,7 +132,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, =
void *data)
> txgbe->eicr =3D eicr;
> if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
> wx_msg_task(txgbe->wx);
> - wx_intr_enable(wx, TXGBE_INTR_MISC);
> + wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> }
> return IRQ_WAKE_THREAD;
> }
> @@ -184,7 +184,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int =
irq, void *data)
> nhandled++;
> }
>=20
> - wx_intr_enable(wx, TXGBE_INTR_MISC);
> + wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
> }
>=20
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 42ec815159e8..41915d7dd372 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -302,8 +302,8 @@ struct txgbe_fdir_filter {
> #define TXGBE_DEFAULT_RX_WORK           128
> #endif
>=20
> -#define TXGBE_INTR_MISC       BIT(0)
> -#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
> +#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
> +#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
>=20
> #define TXGBE_MAX_EITR        GENMASK(11, 3)
>=20
> --=20
> 2.48.1
>=20
>=20
>=20


