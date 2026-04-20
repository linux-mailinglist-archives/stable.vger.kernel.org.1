Return-Path: <stable+bounces-239984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMRLI3R35mmFwwEAu9opvQ
	(envelope-from <stable+bounces-239984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358E4331F9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C32E300D1C8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E73AF670;
	Mon, 20 Apr 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJdG0SiW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4442D73BD
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711538; cv=pass; b=O2scgKUK6dZ4b/WMo++zw1weZdxMN6wB/Xqz/Dl8B9QzrPnHJzM3wiWBvYPhdsupm7849zdmVIXxW8kF+57UIF724s1RXhw2xhDFujE52zaaV2eqy0nMuBledw89VqMXpufoj+GBuYImCJbnpJFygLJEfoXOxpAb70VkPA56R9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711538; c=relaxed/simple;
	bh=p1Wbsl002XCDS04QYcyZu5TJSYOdSRwpb/722QBWnNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaFjh0RVuB9XxDEi5SqSWptsBA6MtsSib5U5BauNGd3x4lcLre6Bafvqpkx921xdPNeVPzc8Z5lNvJQ6BlJueDaLOqNE6zuqawOiwkl3KDoxcZx9F1E3Mv0CXt/Zd4g793/iFd3sMGDCuuy5VNcqycd6UPhnTaNr5i3p9r3ieFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJdG0SiW; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651d692e833so3377381d50.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711535; cv=none;
        d=google.com; s=arc-20240605;
        b=dAdBLHjS9/IUnqbfpHAhsWqeyLofSfPWiA9QxWIIxqeOx8llzpZYta3sOIHqqhEDhb
         vmU9H/qhOrhzMiWtl+RwSCiml77tsV+2LnoZf99W+4RfcXgR+DkGs0bpXb6+D5gSl+ce
         pzHU0uD+ALhgaP2ysQOvNGs4vnvP7XwylA4K/OzyqcGG7QhNokn/Jj1o1iShMGj8/xZK
         wcqRVvtN9AkArCKOXnfozTfZzMDPUwPhuPfjL2EubtnGL/m6+2y/Kdcbq1g303K6rS1T
         HyTmMBvq3f37mluHsAzlxVVyGQOeG1HQ0JmjD6Z4iQQTZoN80yygMmcLN/6cALek0ol6
         dhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CaUC0abcmCiItiszJwnVedBBuYpRSfPUXF06VIKQtVo=;
        fh=Q/f5LH6rAn2UQpb34U8WKTXyOLxpqtESR0TmsmwHH8U=;
        b=B3ubUw+XOZSnHDRp94LLPM95CV1H7BnE9thogXiHVvO8yIeaJPAsojyAU6I0NRaN6O
         XruKqqKPk89Feu72RI8Dh2MJFCpQ+ksQ+mFG3v2NTNXv/ULTmeqqfj32kbZFXHnEjykm
         +89sP6Cxjxutn4M8L2G4Ki3eysrEsOrirX6yIHd5B6A87wVWgZaFuOBsNAe1JlQJQjjx
         R0FSezPl4WHDG2K/d2jTXWOi42E5cvAdfrWeHbRlgXhf9XwIeaOlflqbBEG4skr4mpa0
         y0kRwMVdsI0xwZDfxhw73spJFtykR1N3OWzwM6zaMZ5obP+AEjl/F7H4PowTTF4enSKQ
         kxmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776711535; x=1777316335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaUC0abcmCiItiszJwnVedBBuYpRSfPUXF06VIKQtVo=;
        b=QJdG0SiWXMLatxT15TykFlmS49HsisQdcf0iNh4IRw9IKcuzkXOO3yJp5JacqFT5UE
         GRa2y+bHbpjnMA3eug4R0irWY9dcAQQcR2jUqPsi9oQVS/ihOywDpKp3ZUZsapPXFBBt
         4cAzdyS7nxJB/V6MmVh6cywuPePDxTFcSgQWsFbQd8leCWFlOtMssmgnlZL1OOC0db4n
         CxutOp13mAFIQaXbMuwn3ub3yxMWSwbLmqwaXWfRSp8Q2M8RUSYquxjlDzyAAl+QOeGJ
         o2FxXcFfbzQPjJyGOBg8HAZFDpV+xgAoxoRaJbttGHnkd64DQ+zWye08NoYkD2Twy0ju
         74zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711535; x=1777316335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CaUC0abcmCiItiszJwnVedBBuYpRSfPUXF06VIKQtVo=;
        b=Ig22SVflIwtbj2wGocI0yzmepWbmVSo+Qpwj+o+1R0zmhyypDvIYUT6sr7yxJNoplW
         2jCW6qcquUQjVGjtralr+8GwtWKzpa6kERxGlVgu0SqHsh0c+cnRN/mUM3+UtxrqCiqV
         66Ka7CnG7usGHqdTcXQ2ta9PTMx2choOwe2Iu4MBErAYjqMhPzmxMYv9hAN6DECfXkUD
         dJKfdQTP6HHx3ZhK7g2uUuCeY7Y08yZMDL3sviNtgxHDMLcZwTpii9OG58qLLlDM6/44
         gEHLdimpBI9J3L7kM5w/AhjKBYT28StxCIu7Q9YJNZMJkXpVD2lPHoIwIis1V/bs7O1E
         yXuw==
X-Gm-Message-State: AOJu0YwAv6hylNw9G4waCg81qdFFDJHN7eb6SoET4eAAkX3sZNxtkbHd
	csRep0VSuN+1K89IumK2LFL4csNy/4pvOIwu/OL1R15I5fHWuXxhtg9HlsfKlEpQU660+DTM20Y
	OVE7KzTT2zp1qqwXg0fKmXxlt2tboJUOR9lhp9hzMCDcTOr2cObqC4fv0VaY=
X-Gm-Gg: AeBDiet+1FLbH643HdPhGdsAkJeorC0IZTeCgWdMzQ6HpsLHOIO/Ka4SHD/MZ6+PxQL
	oYQEKyaJoauSg+OulOADwmlYRV2qdgvOGjxn8L/8TyIJ9cE7QO4YsYBeVzfI0fyPJxXqbRWWfld
	9Xg8BSN7BnKvtvIxKpFtbVdAS6NP/HMl9klo8pfzbGOajwvrVEiYmVn3goOZ/HsnjOxJ6BjHw6M
	8uZG/osOCe7t0OkVodr+AjHM9zd+pukwznsUvc59ZJInO97bovLBpNTF2yLCiriDFmi/q0WPl0s
	jdblP6eN11Agp49S2lRPaA2D+vVjx8IGHKf7f7boxpiYmtvtzke+lKDCIWM=
X-Received: by 2002:a05:690e:1c20:b0:650:1aa5:8581 with SMTP id
 956f58d0204a3-6531bd59c13mr13646395d50.37.1776711534785; Mon, 20 Apr 2026
 11:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192555.3631327-1-boolli@google.com> <IA3PR11MB89864E6BED3A633061BB0A1FE52F2@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89864E6BED3A633061BB0A1FE52F2@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Mon, 20 Apr 2026 11:58:41 -0700
X-Gm-Features: AQROBzBmkIcMaDACA2PumCZmO4iOAGOMTgXGz2bFbInbsGSFrHSFnKMySU9Mtc8
Message-ID: <CAODvEq6P3=UgVmtjzqJQOTx27dLQDF7OfqP+9+VUiy=b=6nc0w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when
 netdev is detached
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[google.com:s=20251104];
	TAGGED_FROM(0.00)[bounces-239984-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.794];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,davemloft.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1358E4331F9
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Sun, Apr 19, 2026 at 11:20=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Sunday, April 19, 2026 9:26 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>; Li
> > Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Subject: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when
> > netdev is detached
> >
> > Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> > handling a reset") prevents ethtool -N/-n operations to operate on
> > detached netdevs, we found that out-of-tree workflows like OpenOnload
> > can bypass ethtool core locks and call idpf_set_rxnfc directly during
> > an idpf HW reset. When this happens, we could get kernel crashes like
> > the following:
> >
> > [ 4045.787439] BUG: kernel NULL pointer dereference, address:
> > 0000000000000070 [ 4045.794420] #PF: supervisor read access in kernel
> > mode [ 4045.799580] #PF: error_code(0x0000) - not-present page [
> > 4045.804739] PGD 0 [ 4045.806772] Oops: Oops: 0000 [#1] SMP NOPTI ...
> > [ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn
> > [onload] [ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170
> > [idpf] ...
> > [ 4045.946323] Call Trace:
> > [ 4045.948796]  <TASK>
> > [ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0 [ 4045.955293]  ?
> > show_trace_log_lvl+0x1b0/0x2f0 [ 4045.959672]  ?
> > idpf_set_rxnfc+0x6f/0x80 [idpf] [ 4045.964142]  ?
> > __die_body.cold+0x8/0x12 [ 4045.968000]  ? page_fault_oops+0x148/0x160
> > [ 4045.972117]  ? exc_page_fault+0x6f/0x160 [ 4045.976060]  ?
> > asm_exc_page_fault+0x22/0x30 [ 4045.980262]  ?
> > idpf_del_flow_steer+0x24/0x170 [idpf] [ 4045.985245]
> > idpf_set_rxnfc+0x6f/0x80 [idpf] [ 4045.989535]
> > af_xdp_filter_remove+0x7c/0xb0 [sfc_resource] [ 4045.995069]
> > oo_hw_filter_clear_hwports+0x6f/0xa0 [onload] [ 4046.000589]
> > oo_hw_filter_update+0x65/0x210 [onload] [ 4046.005587]
> > oof_hw_filter_update.constprop.0+0xe7/0x140 [onload] [ 4046.011716]
> > oof_manager_update_all_filters+0xad/0x270 [onload] [ 4046.017671]
> > __oof_do_deferred_work+0x15e/0x190 [onload] [ 4046.023014]
> > oof_do_deferred_work+0x2c/0x40 [onload] [ 4046.028018]
> > oof_do_deferred_work_fn+0x12/0x30 [onload] [ 4046.033277]
> > process_one_work+0x174/0x330 [ 4046.037304]  worker_thread+0x246/0x390
> > [ 4046.041074]  ? __pfx_worker_thread+0x10/0x10 [ 4046.045364]
> > kthread+0xf6/0x240 [ 4046.048530]  ? __pfx_kthread+0x10/0x10 [
> > 4046.052297]  ret_from_fork+0x2d/0x50 [ 4046.055896]  ?
> > __pfx_kthread+0x10/0x10 [ 4046.059664]  ret_from_fork_asm+0x1a/0x30 [
> > 4046.063613]  </TASK>
> >
> > To prevent this, we need to add checks in idpf_set_rxnfc and
> > idpf_get_rxnfc to error out if the netdev is already detached.
> >
> > Tested: implemented the following patch to synthetically force idpf
> > into a HW reset:
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index 4fc0bb14c5b1..27476d57bcf0 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -10,6 +10,9 @@
> >  #define idpf_tx_buf_next(buf)                (*(u32 *)&(buf)->priv)
> >  LIBETH_SQE_CHECK_PRIV(u32);
> >
> > +static bool SIMULATE_TX_TIMEOUT;
> > +module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
> > +
> >  /**
> >   * idpf_chk_linearize - Check if skb exceeds max descriptors per
> > packet
> >   * @skb: send buffer
> > @@ -46,6 +49,8 @@ void idpf_tx_timeout(struct net_device *netdev,
> > unsigned int txqueue)
> >
> >       adapter->tx_timeout_count++;
> >
> > +     SIMULATE_TX_TIMEOUT =3D false;
> > +
> >       netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
> >                  adapter->tx_timeout_count, txqueue);
> >       if (!idpf_is_reset_in_prog(adapter)) { @@ -2225,6 +2230,8 @@
> > static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int
> > budget,
> >                       goto fetch_next_desc;
> >               }
> >               tx_q =3D complq->txq_grp->txqs[rel_tx_qid];
> > +             if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx % 2 =3D=3D
> > 1)))
> > +                     goto fetch_next_desc;
> >
> >               /* Determine completion type */
> >               ctype =3D le16_get_bits(tx_desc->common.qid_comptype_gen,
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index be66f9b2e101..ba5da2a86c15 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -8,6 +8,9 @@
> >  #include "idpf_virtchnl.h"
> >  #include "idpf_ptp.h"
> >
> > +static bool VIRTCHNL_FAILED;
> > +module_param(VIRTCHNL_FAILED, bool, 0644);
> > +
> >  /**
> >   * struct idpf_vc_xn_manager - Manager for tracking transactions
> >   * @ring: backing and lookup for transactions @@ -3496,6 +3499,11 @@
> > int idpf_vc_core_init(struct idpf_adapter *adapter)
> >               switch (adapter->state) {
> >               case __IDPF_VER_CHECK:
> >                       err =3D idpf_send_ver_msg(adapter);
> > +
> > +                     if (unlikely(VIRTCHNL_FAILED)) {
> > +                             err =3D -EIO;
> > +                     }
> > +
> >                       switch (err) {
> >                       case 0:
> >                               /* success, move state machine forward */
> >
> > And tested by writing 1 to /sys/module/idpf/parameters/VIRTCHNL_FAILED
> > and /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT, and running
> > idpf_get_rxnfc() right after the HW reset.
> >
> > Without the patch: encountered NULL pointer and kernel crash.
> >
> > With the patch: no crashes.
> >
> > Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a
> > reset")
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > index bb99d9e7c65d..8368a7e6a754 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> > @@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev,
> > struct ethtool_rxnfc *cmd,
> >       unsigned int cnt =3D 0;
> >       int err =3D 0;
> >
> > +     if (!netdev || !netif_device_present(netdev))
> > +             return -ENODEV;
> > +
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> >       vport_config =3D np->adapter->vport_config[np->vport_idx];
> > @@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device
> > *netdev, struct ethtool_rxnfc *cmd)  {
> >       int ret =3D -EOPNOTSUPP;
> >
> > +     if (!netdev || !netif_device_present(netdev))
> > +             return -ENODEV;
> > +
> >       idpf_vport_ctrl_lock(netdev);
> >       switch (cmd->cmd) {
> >       case ETHTOOL_SRXCLSRLINS:
> > --
> > 2.54.0.rc1.513.gad8abe7a5a-goog
>
> Please add Cc: stable@vger.kernel.org
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


Sounds good, I CC'ed stable@vger.kernel.org and will append it to all
ongoing comments.

Thanks!

