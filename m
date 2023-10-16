Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A337CAC6E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJPOye (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjJPOyd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8055CE1;
        Mon, 16 Oct 2023 07:54:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DC6C433C8;
        Mon, 16 Oct 2023 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697468071;
        bh=s/VRWj66mkawiyCQiIKItGofUD+YauMZ/L3raQJNZyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf05Y7TmLUsWRS3GHZLq97gsFdEUKrh10GtL2G+Ds3xydUMW4eIwEAzkpVyCO37h2
         VjIzOgMlO0f6N/gfAWNrBNdP8LagQVXdZY3GfKGWt93yQmZ9e4wZrlYIjvVnMXmpNO
         MNVLkXovmo0FNQvPRxCdgwow25XVYPcMuivB/c5Ustu9p6MDtDk4cXkjOCavWlGyGj
         MdBjlTVB2HZy5Rs3npFey8UNOk5BXMqk2Gv7JzmSickeTfueIILcvFjVsjrAvG2kkO
         3VOwxBAW/Oy74AWxrd/e8yij0vXGf+xL6N/NObHxLnBQaeRFZuF2zW9WdyDPCoGnkO
         ALqoJdD0DzmyQ==
Date:   Mon, 16 Oct 2023 15:54:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: stable-rc/linux-4.19.y bisection: baseline.dmesg.emerg on
 meson-gxm-q200
Message-ID: <7f942203-7bdf-480a-95bf-8b78426d3e28@sirena.org.uk>
References: <652d4b68.170a0220.3b458.fd95@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LcUlVISh0GomjiCY"
Content-Disposition: inline
In-Reply-To: <652d4b68.170a0220.3b458.fd95@mx.google.com>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--LcUlVISh0GomjiCY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 07:40:40AM -0700, KernelCI bot wrote:

The KernelCI bisection bot has identified that commit 74fc50666e0af
("mmc: meson-gx: remove redundant mmc_request_done() call from irq
context") in v4.19 stable-rc is causing boot splats for meson-gxm-q200.
Full report below, including links to the full boot logs:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> stable-rc/linux-4.19.y bisection: baseline.dmesg.emerg on meson-gxm-q200
>=20
> Summary:
>   Start:      b3c2ae79aa73e Linux 4.19.297-rc1
>   Plain log:  https://storage.kernelci.org/stable-rc/linux-4.19.y/v4.19.2=
96-42-gb3c2ae79aa73/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.txt
>   HTML log:   https://storage.kernelci.org/stable-rc/linux-4.19.y/v4.19.2=
96-42-gb3c2ae79aa73/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.html
>   Result:     74fc50666e0af mmc: meson-gx: remove redundant mmc_request_d=
one() call from irq context
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       stable-rc
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git
>   Branch:     linux-4.19.y
>   Target:     meson-gxm-q200
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   gcc-10
>   Config:     defconfig
>   Test case:  baseline.dmesg.emerg
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 74fc50666e0af2514a7e6b0937166a75692c2a42
> Author: Martin Hundeb=F8ll <martin@geanix.com>
> Date:   Wed Jun 7 10:27:12 2023 +0200
>=20
>     mmc: meson-gx: remove redundant mmc_request_done() call from irq cont=
ext
>    =20
>     [ Upstream commit 3c40eb8145325b0f5b93b8a169146078cb2c49d6 ]
>    =20
>     The call to mmc_request_done() can schedule, so it must not be called
>     from irq context. Wake the irq thread if it needs to be called, and l=
et
>     its existing logic do its work.
>    =20
>     Fixes the following kernel bug, which appears when running an RT patc=
hed
>     kernel on the AmLogic Meson AXG A113X SoC:
>     [   11.111407] BUG: scheduling while atomic: kworker/0:1H/75/0x000100=
01
>     [   11.111438] Modules linked in:
>     [   11.111451] CPU: 0 PID: 75 Comm: kworker/0:1H Not tainted 6.4.0-rc=
3-rt2-rtx-00081-gfd07f41ed6b4-dirty #1
>     [   11.111461] Hardware name: RTX AXG A113X Linux Platform Board (DT)
>     [   11.111469] Workqueue: kblockd blk_mq_run_work_fn
>     [   11.111492] Call trace:
>     [   11.111497]  dump_backtrace+0xac/0xe8
>     [   11.111510]  show_stack+0x18/0x28
>     [   11.111518]  dump_stack_lvl+0x48/0x60
>     [   11.111530]  dump_stack+0x18/0x24
>     [   11.111537]  __schedule_bug+0x4c/0x68
>     [   11.111548]  __schedule+0x80/0x574
>     [   11.111558]  schedule_loop+0x2c/0x50
>     [   11.111567]  schedule_rtlock+0x14/0x20
>     [   11.111576]  rtlock_slowlock_locked+0x468/0x730
>     [   11.111587]  rt_spin_lock+0x40/0x64
>     [   11.111596]  __wake_up_common_lock+0x5c/0xc4
>     [   11.111610]  __wake_up+0x18/0x24
>     [   11.111620]  mmc_blk_mq_req_done+0x68/0x138
>     [   11.111633]  mmc_request_done+0x104/0x118
>     [   11.111644]  meson_mmc_request_done+0x38/0x48
>     [   11.111654]  meson_mmc_irq+0x128/0x1f0
>     [   11.111663]  __handle_irq_event_percpu+0x70/0x114
>     [   11.111674]  handle_irq_event_percpu+0x18/0x4c
>     [   11.111683]  handle_irq_event+0x80/0xb8
>     [   11.111691]  handle_fasteoi_irq+0xa4/0x120
>     [   11.111704]  handle_irq_desc+0x20/0x38
>     [   11.111712]  generic_handle_domain_irq+0x1c/0x28
>     [   11.111721]  gic_handle_irq+0x8c/0xa8
>     [   11.111735]  call_on_irq_stack+0x24/0x4c
>     [   11.111746]  do_interrupt_handler+0x88/0x94
>     [   11.111757]  el1_interrupt+0x34/0x64
>     [   11.111769]  el1h_64_irq_handler+0x18/0x24
>     [   11.111779]  el1h_64_irq+0x64/0x68
>     [   11.111786]  __add_wait_queue+0x0/0x4c
>     [   11.111795]  mmc_blk_rw_wait+0x84/0x118
>     [   11.111804]  mmc_blk_mq_issue_rq+0x5c4/0x654
>     [   11.111814]  mmc_mq_queue_rq+0x194/0x214
>     [   11.111822]  blk_mq_dispatch_rq_list+0x3ac/0x528
>     [   11.111834]  __blk_mq_sched_dispatch_requests+0x340/0x4d0
>     [   11.111847]  blk_mq_sched_dispatch_requests+0x38/0x70
>     [   11.111858]  blk_mq_run_work_fn+0x3c/0x70
>     [   11.111865]  process_one_work+0x17c/0x1f0
>     [   11.111876]  worker_thread+0x1d4/0x26c
>     [   11.111885]  kthread+0xe4/0xf4
>     [   11.111894]  ret_from_fork+0x10/0x20
>    =20
>     Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Martin Hundeb=F8ll <martin@geanix.com>
>     Link: https://lore.kernel.org/r/20230607082713.517157-1-martin@geanix=
=2Ecom
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 313aff92b97c9..a3e5be81b4660 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1067,11 +1067,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *de=
v_id)
>  	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
>  		if (data && !cmd->error)
>  			data->bytes_xfered =3D data->blksz * data->blocks;
> -		if (meson_mmc_bounce_buf_read(data) ||
> -		    meson_mmc_get_next_command(cmd))
> -			ret =3D IRQ_WAKE_THREAD;
> -		else
> -			ret =3D IRQ_HANDLED;
> +
> +		return IRQ_WAKE_THREAD;
>  	}
> =20
>  out:
> @@ -1086,9 +1083,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev=
_id)
>  		writel(start, host->regs + SD_EMMC_START);
>  	}
> =20
> -	if (ret =3D=3D IRQ_HANDLED)
> -		meson_mmc_request_done(host->mmc, cmd->mrq);
> -
>  	return ret;
>  }
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [94bffc1044d871e2ec89b2621e9a384355832988] Linux 4.19.288
> git bisect good 94bffc1044d871e2ec89b2621e9a384355832988
> # bad: [b3c2ae79aa73e61b75d4fa6f3dae226b59b7bd41] Linux 4.19.297-rc1
> git bisect bad b3c2ae79aa73e61b75d4fa6f3dae226b59b7bd41
> # bad: [5f63100cf9a673eaef15a1b1415d7a480af1571c] net: phy: broadcom: stu=
b c45 read/write for 54810
> git bisect bad 5f63100cf9a673eaef15a1b1415d7a480af1571c
> # good: [916a02b6487f90cfcda24636e9b2b8da38b96bbc] net: ethernet: ti: cps=
w_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
> git bisect good 916a02b6487f90cfcda24636e9b2b8da38b96bbc
> # good: [f114bcacd558aaae6eb2bff350ae305632e4e37e] ARM: dts: imx6sll: fix=
up of operating points
> git bisect good f114bcacd558aaae6eb2bff350ae305632e4e37e
> # good: [56804da32a6edef397e9d967b01e82a4b04a8e9d] IMA: allow/fix UML bui=
lds
> git bisect good 56804da32a6edef397e9d967b01e82a4b04a8e9d
> # bad: [97a2d55ead76358245b446efd87818e919196d7a] virtio-mmio: don't brea=
k lifecycle of vm_dev
> git bisect bad 97a2d55ead76358245b446efd87818e919196d7a
> # good: [cbc6a5f11ca2a622f77bcb6901b274bd995653d6] irqchip/mips-gic: Use =
raw spinlock for gic_lock
> git bisect good cbc6a5f11ca2a622f77bcb6901b274bd995653d6
> # bad: [22b64a6b59fc2107d304715d8a778eebeb8659ae] mmc: Remove dev_err() u=
sage after platform_get_irq()
> git bisect bad 22b64a6b59fc2107d304715d8a778eebeb8659ae
> # good: [d7aacfd2e388519434acf504a6b53099cc4da978] mmc: meson-gx: remove =
useless lock
> git bisect good d7aacfd2e388519434acf504a6b53099cc4da978
> # bad: [e1036bf905f9ec7b01fd5ee946a9a94f9671ee83] mmc: tmio: replace tmio=
_mmc_clk_stop() calls with tmio_mmc_set_clock()
> git bisect bad e1036bf905f9ec7b01fd5ee946a9a94f9671ee83
> # bad: [74fc50666e0af2514a7e6b0937166a75692c2a42] mmc: meson-gx: remove r=
edundant mmc_request_done() call from irq context
> git bisect bad 74fc50666e0af2514a7e6b0937166a75692c2a42
> # first bad commit: [74fc50666e0af2514a7e6b0937166a75692c2a42] mmc: meson=
-gx: remove redundant mmc_request_done() call from irq context
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#47481): https://groups.io/g/kernelci-results/message/=
47481
> Mute This Topic: https://groups.io/mt/101996911/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--LcUlVISh0GomjiCY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtTqEACgkQJNaLcl1U
h9C5lgf+MFxKC+anUp6smAFWMKE9yF7LZbkhIQRldpP9uFwq/MoMqIOFGWDOXI3b
X2U4FFJhIdkqLJBOFNrlHnOf0VHdwmrMHkxaU3AaQKRFvqH+zS4VJsPwnIq77kP/
ZeK52LgG8u8jfqf/kB0O4r7NWJVh8dhTfmJBBHU6O29f3D4nKQDih8fmJn/yIdTT
Uy1QEKjGQNOOwBYdz+3WE8hVYkdC/3XCUKApBS9+ocuDHK2qi9y+S2r2LGPE9WtT
W7GHPvW8SSacAr065gbkqpVZMNLjHgTDadBurq60sW0N668ozFW+kDYD0fz3C0lQ
cHp+oJbL4/Wb9DVtOat8oEcEq9SZTA==
=wM1O
-----END PGP SIGNATURE-----

--LcUlVISh0GomjiCY--
