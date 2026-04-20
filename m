Return-Path: <stable+bounces-239954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD/JJVVe5mm3vQEAu9opvQ
	(envelope-from <stable+bounces-239954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168E430B81
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 130B9303A3DE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCD37DE92;
	Mon, 20 Apr 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzdYUAzB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73E37DE8A
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704605; cv=pass; b=ipF3c6aaCddHPH78nrkaX2qI4Z5crU6ox3tKLIC3VYFDlJRxtkY8H30I6d9sPKf7Uo5VdA65g5MLpocMfLQz4G50mT0G7onGGDSKgUOKw/akJbIfifLTEe8X6ieXt9B9OQwOeS1kZBksQGWz69D8YhX+e0u08hIxmxy5Y6sYDcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704605; c=relaxed/simple;
	bh=MY8cWEKzzznpHqY2ZL9obKtvFQwLdK0P2oXtkA1iJr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvGx4RSttbBwO2tx1+NCqZCGd3/aDiqFHhhNf6i+2vxpA2aykYHl+nmwGYhBW3KTxE86DXKR4d6+9tqgoM6M4oRtT0LmjV7bqRmWOPEDPLJx5iETm0fAhRo0pZWnzNJ6pmdIuhv7bLJvj9P6ZVZu60svZ1NbQtoivciICbuH1IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzdYUAzB; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so3767180d50.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776704603; cv=none;
        d=google.com; s=arc-20240605;
        b=Z73SJiJkr+ftTiZkGnkn65s5I3T6Idm2tP7nn/ccbh0oLcNcDqHwoaeGUmvsrDfdF7
         LYSZZaKRUDknZiZP8bBCuu77jM1tK48I6PRFoBV9as5W0FjK3em6ZE53tIaDosPIe9+G
         Oaxh1HFUFyGFElJUnrC5B7pHqonczIk2yc/0DppgKB8UcTx1FEF0rmS3jrxhIRDkj9Uw
         RWwLAiVn/CNvUPhCWgoM0D7PSb/zRLz/1OOMjsS2LdfS+sGDsSOvpbBYGaVMVUYyPEuB
         ZLcIuabz7o4j6SDv9nF1/ylONEPLshPGC6ltM42Z+AibspuWCjgyhZaLIfWyKJDezF9c
         OGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        fh=Iyn5mFCvZ+8IjXSETUfiLZ4bBiH0LV/BOlN9eu18T+o=;
        b=byPS3cZFZwnnvBdsf91/84zSph2z7h9JS++TC9XImndvmFggX2FoZNQyqecKACyLYt
         lGBuswB2OTCBWjbKO317hSBch9SJxQUuD39mDpawWxP/H0AWwzX2brevsxJpQ2Zb7wv9
         9181ozDiAE+r6hCoOSZ70TKE9aF1dLTVs9WHHREV5rutcbA5Ylyjt4Y7UM7Hs6M0Cdu/
         SJYLngjsPHUCkRwxvBlqQ4j/lhVUTlTwOkER0DhJ5Zyv4m4kepfDVTQQFfy9DyJdnZkx
         gw68F12OAFDvqAMuAVuLX2WhiJObo0blyWVfwBFJTFApWTCGGIPcPD4Ehb7L41SwzUtA
         oEGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776704603; x=1777309403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        b=fzdYUAzB25VyAQUlM195lS0A5tRyWmxhZtCVRmSN+VymgpXmf+nfVmsXaGdueI+4ZN
         cRDK/OmokmnXOjGkGBc/SAE4990vxc7KTiIrYSSLyS6ujv/kkvqUDaycunGU0JMwB4B5
         ZlhfRi+TKqzD5yykXpyrKDag8B617STfvqhmehdi0COReaYHkha1pLhR45e258ZcQYGW
         AHRQ7Ay1zvpwEqHnV+7tCzfSOM/PqJO0Eb2KV6OyKwuNrrw/Jm0imXqQaQaqwEhsr0bZ
         PJ9IzHQWvAoLIDvrO+8Boz2O8vSU/I8X8Fya83JISHAF9xNkZb8aLl2/KzLjWnjbtMxj
         un9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776704603; x=1777309403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuwHzur0DyTT6fAN7548X05vvqlUKr6sImf2XcXe9sE=;
        b=svcD1zGdqi41cYxIG8otRtn208n/X/QET5wY1Kf4LY/hOM/1P/3+RlzV//JwCK6nbd
         hjEUx5cF7fZH32d4daqxMLzD1jQv5KG/PqCbEPzUt/d9hh7+m/OOn7hBmBQgD+SmU/JD
         apfOewhIM1vMOeBTBLuvs7Tux7kU6mXIwarKj1U0wZ2SGQkKI8vELAoerqvwZ6kvBIQ7
         JEJLHOfrCb2oOCZJ7qkSBKECxHBwyNaVZXVZ/nHj/tVi0Ja11cu4HEQqrAYVzYkmLQGR
         Bo1+srnkbenp0bK9kKlTOm/I0Swlo7jbSaXiAWrVfx5iGuNwjhzDrIbydruwRAigkQZN
         CxtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3w/dEG0oEPc20o+PGTa4s9EvR0Iz5rUtlzYNDLr+/wWGFqw61oRe8RT4UzxCtLrxDYBpz+tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqbokq3IJqLtp3hTvV7DoLe6vpm6CdMfUtcoRU/WYQJOzMazRC
	nfLtH1PR1UbOLFs9CdsTh7PVQYC2qm864X5He9DjWCWjdHUh7hkdOstFdUiaa8CVj6qcURFU0w4
	JlAjZndajUCSNWdG5BaIme4TAMdIMiXvktOJWsS2V
X-Gm-Gg: AeBDiesKnaJ+fYJhyKoneNScw8d48j88GxYv3TkOy65lJ6QJyGXmxYVkn1r0Pzo/Ype
	inIuZpUbIwVq8UmARS1tAHbQaw3rW0qYdG/2QO/8DX9BTX65DzJRCspOyIt+lVAKbvZ/Jcqn9dp
	uWGajlsUR4LZhQUl+6ItBImg8RRWVf7m2yCh3ZcVHvYPCI0nWvxcyLnRCdvUwjDN5laLW5T/Fuw
	G7K7j3lrAnuJwRbm7DQM5+gzLv7df4/hfe30CME/+Liq8wcrmYp6v4U/fV69GdTi21++jE9UUvy
	6y6Bg9SHatMbNQyWfrmQOsgk+vFvNL0xalJHEk66amLfTvXsSKmmVpoZ250=
X-Received: by 2002:a05:690e:124a:b0:650:1bc2:7e18 with SMTP id
 956f58d0204a3-65310803466mr14402341d50.1.1776704601042; Mon, 20 Apr 2026
 10:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192555.3631327-1-boolli@google.com> <PH7PR11MB59834C3C7785D1E69B7E954EF32F2@PH7PR11MB5983.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59834C3C7785D1E69B7E954EF32F2@PH7PR11MB5983.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Mon, 20 Apr 2026 10:03:08 -0700
X-Gm-Features: AQROBzCRU8m1PocV3KnbRH0zjFz61ZPVhxSInF_uNWzvauXiSpZzp7JJjroMqgY
Message-ID: <CAODvEq41VxdJ+nmM49eNo4d4VYBoDF69hzQUe8dUP9RoAuxxGA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when
 netdev is detached
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239954-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,davemloft.net:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email]
X-Rspamd-Queue-Id: 1168E430B81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 1:23=E2=80=AFAM Kwapulinski, Piotr
<piotr.kwapulinski@intel.com> wrote:
>
> >-----Original Message-----
> >From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of =
Li Li via Intel-wired-lan
> >Sent: Sunday, April 19, 2026 9:26 PM
> >To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>; Jaku=
b Kicinski <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; intel-wir=
ed-lan@lists.osuosl.org
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David Decotign=
y <decot@google.com>; Singhai, Anjali <anjali.singhai@intel.com>; Samudrala=
, Sridhar <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>=
; Li Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> >Subject: [Intel-wired-lan] [PATCH] idpf: do not perform flow ops when ne=
tdev is detached
> >
> >Even though commit 2e281e1155fc ("idpf: detach and close netdevs while h=
andling a reset") prevents ethtool -N/-n operations to operate on detached =
netdevs, we found that out-of-tree workflows like OpenOnload can bypass eth=
tool core locks and call idpf_set_rxnfc directly during an idpf HW reset. W=
hen this happens, we could get kernel crashes like the following:
> >
> >[ 4045.787439] BUG: kernel NULL pointer dereference, address: 0000000000=
000070 [ 4045.794420] #PF: supervisor read access in kernel mode [ 4045.799=
580] #PF: error_code(0x0000) - not-present page [ 4045.804739] PGD 0 [ 4045=
.806772] Oops: Oops: 0000 [#1] SMP NOPTI ...
> >[ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn [onload]=
 [ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170 [idpf] ...
> >[ 4045.946323] Call Trace:
> >[ 4045.948796]  <TASK>
> >[ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0 [ 4045.955293]  ? show_=
trace_log_lvl+0x1b0/0x2f0 [ 4045.959672]  ? idpf_set_rxnfc+0x6f/0x80 [idpf]=
 [ 4045.964142]  ? __die_body.cold+0x8/0x12 [ 4045.968000]  ? page_fault_oo=
ps+0x148/0x160 [ 4045.972117]  ? exc_page_fault+0x6f/0x160 [ 4045.976060]  =
? asm_exc_page_fault+0x22/0x30 [ 4045.980262]  ? idpf_del_flow_steer+0x24/0=
x170 [idpf] [ 4045.985245]  idpf_set_rxnfc+0x6f/0x80 [idpf] [ 4045.989535] =
 af_xdp_filter_remove+0x7c/0xb0 [sfc_resource] [ 4045.995069]  oo_hw_filter=
_clear_hwports+0x6f/0xa0 [onload] [ 4046.000589]  oo_hw_filter_update+0x65/=
0x210 [onload] [ 4046.005587]  oof_hw_filter_update.constprop.0+0xe7/0x140 =
[onload] [ 4046.011716]  oof_manager_update_all_filters+0xad/0x270 [onload]=
 [ 4046.017671]  __oof_do_deferred_work+0x15e/0x190 [onload] [ 4046.023014]=
  oof_do_deferred_work+0x2c/0x40 [onload] [ 4046.028018]  oof_do_deferred_w=
ork_fn+0x12/0x30 [onload] [ 4046.033277]  process_one_work+0x174/0x330 [ 40=
46.037304]  worker_thread+0x246/0x390 [ 4046.041074]  ? __pfx_worker_thread=
+0x10/0x10 [ 4046.045364]  kthread+0xf6/0x240 [ 4046.048530]  ? __pfx_kthre=
ad+0x10/0x10 [ 4046.052297]  ret_from_fork+0x2d/0x50 [ 4046.055896]  ? __pf=
x_kthread+0x10/0x10 [ 4046.059664]  ret_from_fork_asm+0x1a/0x30 [ 4046.0636=
13]  </TASK>
> >
> >To prevent this, we need to add checks in idpf_set_rxnfc and idpf_get_rx=
nfc to error out if the netdev is already detached.
> >
> >Tested: implemented the following patch to synthetically force idpf into=
 a HW reset:
> >
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/e=
thernet/intel/idpf/idpf_txrx.c
> >index 4fc0bb14c5b1..27476d57bcf0 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >@@ -10,6 +10,9 @@
> > #define idpf_tx_buf_next(buf)         (*(u32 *)&(buf)->priv)
> > LIBETH_SQE_CHECK_PRIV(u32);
> >
> >+static bool SIMULATE_TX_TIMEOUT;
> >+module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
> >+
> > /**
> >  * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
> >  * @skb: send buffer
> >@@ -46,6 +49,8 @@ void idpf_tx_timeout(struct net_device *netdev, unsign=
ed int txqueue)
> >
> >       adapter->tx_timeout_count++;
> >
> >+      SIMULATE_TX_TIMEOUT =3D false;
> >+
> >       netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
> >                  adapter->tx_timeout_count, txqueue);
> >       if (!idpf_is_reset_in_prog(adapter)) { @@ -2225,6 +2230,8 @@ stat=
ic bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
> >                       goto fetch_next_desc;
> >               }
> >               tx_q =3D complq->txq_grp->txqs[rel_tx_qid];
> >+              if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx % 2 =3D=3D=
 1)))
> >+                      goto fetch_next_desc;
> >
> >               /* Determine completion type */
> >               ctype =3D le16_get_bits(tx_desc->common.qid_comptype_gen,
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/n=
et/ethernet/intel/idpf/idpf_virtchnl.c
> >index be66f9b2e101..ba5da2a86c15 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> >@@ -8,6 +8,9 @@
> > #include "idpf_virtchnl.h"
> > #include "idpf_ptp.h"
> >
> >+static bool VIRTCHNL_FAILED;
> >+module_param(VIRTCHNL_FAILED, bool, 0644);
> >+
> > /**
> >  * struct idpf_vc_xn_manager - Manager for tracking transactions
> >  * @ring: backing and lookup for transactions @@ -3496,6 +3499,11 @@ in=
t idpf_vc_core_init(struct idpf_adapter *adapter)
> >               switch (adapter->state) {
> >               case __IDPF_VER_CHECK:
> >                       err =3D idpf_send_ver_msg(adapter);
> >+
> >+                      if (unlikely(VIRTCHNL_FAILED)) {
> >+                              err =3D -EIO;
> >+                      }
> Please remove redundant parenthesis
> Piotr

Hi Piotr,

The block you are commenting on is not part of the patch; it's just a
block of test code in the commit message I used to reproduce the
failures.

Thanks!

>
> >+
> >                       switch (err) {
> >                       case 0:
> >                               /* success, move state machine forward */
> >
> >And tested by writing 1 to /sys/module/idpf/parameters/VIRTCHNL_FAILED
> >and /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT, and running
> >idpf_get_rxnfc() right after the HW reset.
> >
> >Without the patch: encountered NULL pointer and kernel crash.
> >
> >With the patch: no crashes.
> >
> >Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a re=
set")
> >Signed-off-by: Li Li <boolli@google.com>
> >---
> > drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_ethtool.c
> >index bb99d9e7c65d..8368a7e6a754 100644
> >--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> >@@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, s=
truct ethtool_rxnfc *cmd,
> >       unsigned int cnt =3D 0;
> >       int err =3D 0;
> >
> >+      if (!netdev || !netif_device_present(netdev))
> >+              return -ENODEV;
> >+
> >       idpf_vport_ctrl_lock(netdev);
> >       vport =3D idpf_netdev_to_vport(netdev);
> >       vport_config =3D np->adapter->vport_config[np->vport_idx];
> >@@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev,=
 struct ethtool_rxnfc *cmd)  {
> >       int ret =3D -EOPNOTSUPP;
> >
> >+      if (!netdev || !netif_device_present(netdev))
> >+              return -ENODEV;
> >+
> >       idpf_vport_ctrl_lock(netdev);
> >       switch (cmd->cmd) {
> >       case ETHTOOL_SRXCLSRLINS:
> >--
> >2.54.0.rc1.513.gad8abe7a5a-goog

