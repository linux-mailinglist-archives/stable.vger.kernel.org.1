Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B17C9D95
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 05:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjJPDEn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 23:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDEm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 23:04:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DFC5
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 20:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncBx5ZHZoJufR/KMbE5egzsPVCf6Wx3DZKgPupBAGxuxWu/4imbC3VFiOYUFwNZpX8wjBm/xwzTpsBY0fPIb2jkwzt8fe550yODLeCWJMKbeuyr2//SF8ACnhHwBmDh2e/fn6l+WhD39/qWX3Jv0hfunMXI92f80Yc7HKRtXHoS/Ni5xIWUL1f3A9uAeS9a2cpKKdFWU986aIeiteKzTFAgS7u6Nm12zGsWW9y0JloxEKbqMGnkxFla7CVCXns4RhOkz7OH1FnbFc0Mj2WZAB9JfVEX6UI2Zawc6Sw9FmA5MX6sSKwiOhmANoaK/Xe3B9x2h+zbR/tZIyKkZumkjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oP6aN+Qj3eOx59SoPjjdYyblalibJR1uMdSjCbKt+0=;
 b=PR6XBwi3lXS3Q3HFfkmj4V1Ppz6iShhdH6ti/IlJ3jy1MQE537xH6QxK6yxEJ1+lDzgAs/9DxXxZiCGVccTOQBMZnjwOx1qAR6pO13Ei9zk0LJtgsVOCZOvLIh2RxaLzQnix01EsFDOPQgo5UD4DO3UoK1jSvbmHdnU9Vef0hIbV2dKg6z6AztOvSa1A2Duv/itMmh3GFqyiQyi6jcwV3jpRTFYfdjC0LBfLRAYAFAQ81HpfufIj8zWl6PFb4RH9Ur7eae/krCQmc+T+v3uyrFEcCH1bpBN2nmkfkv1Xy/XwwkPQwFiPpxtHvF4lgut9/IqYWSgN5ZW7oMPNh3xylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oP6aN+Qj3eOx59SoPjjdYyblalibJR1uMdSjCbKt+0=;
 b=YanglMU61p4hQO/y38en/xt8T36x9ZQDFpyZaCFdu4juEFg0bz/2uWldfXdCrm6iks786QJ8M4s+RHd5EsfBFD8XTvzxg++aTKUgsLZnRpJCWzdGJqa9M85wnjmQXGslbsMKRoJwsXIVRZoWtAg2Ho0fmm+0Qnq8IdJBEMSeJCk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8837.jpnprd01.prod.outlook.com
 (2603:1096:400:168::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 03:04:36 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:04:36 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: backport a patch of ravb for v5.10 and v5.4
Thread-Topic: backport a patch of ravb for v5.10 and v5.4
Thread-Index: Adn/2cQgEdmlpKFOSjuBOB6BJ3HKHA==
Date:   Mon, 16 Oct 2023 03:04:36 +0000
Message-ID: <TYBPR01MB53411662F810BAA815FAF968D8D7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8837:EE_
x-ms-office365-filtering-correlation-id: a1d16695-dd90-4ead-e5e0-08dbcdf4a158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fvyef1W3JWPnYEHxarYjcKspffeUWmAfyHqSJFy2pcWtADvRddPEab0WNKVHIUfHzRuqCoTlpLRXHyF3fE+R5rudXSmL1vNHcndg8ly7UAmejGf6Np3ckdt/xZV8gl9S2ajuRPg0PWgCq1wRzkP/4EWDRNMDqR6SAzEK78eEHkIazWxvnGUaWW97x87y5YC/Yl0pkbgZU1+SELtpiQN40Llno9J1ER/WIjwuKzmTX7lztDLjz3iHDUfz24AqGP9ZAu3Py7Yu2l4IeNpmJWo0T74v8uFFclxs1ZvxHnD+G1oP/exr9DkA9kAw3k+dpkpR17KP5mE3ZTuj0ZXmShJTTXZ/xRIhYcogs7kSMY6m+wUaSn9/Bv4G91d3I4eIkI2M09UKkgj9cuUWpKBv3XmmP3tdRnJImrTda8Icrj8/1g+pApSL8/MMaOAHOLppPNBRsPX6Y4PhQMey/itTeNA+mW9H7J9m6R9t4ozY8JbmuGRAGZdINfcJVw5GpBS9fE0FD3v3f90Iz3oEjO5NHQ5C20g5useWdEWpgPEw9GklQ9Q1AnhBUDQearyAMThM4kmjfDBQ1BN7pJZynvoRrhDcV5ErBOqa0MozSjM2vCxY8/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(52536014)(55016003)(38070700005)(8936002)(8676002)(4326008)(71200400001)(33656002)(5660300002)(38100700002)(122000001)(83380400001)(41300700001)(478600001)(86362001)(966005)(2906002)(316002)(7696005)(6506007)(9686003)(66946007)(54906003)(66556008)(66476007)(66446008)(64756008)(76116006)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1q+VpOnNsZOswzNgpeZJ1REwL7lL97WbLMBV/bjaV8rCbchcAfcFs2SFhN3t?=
 =?us-ascii?Q?8tihjrgM8tx0rt/+hbt5uWxi+YwypP3VtuZPAPajjGsoYadd2tGyeb+BGw1V?=
 =?us-ascii?Q?JONlUgNvwrE3nHNcX84CmLjcd0jgt0GUXu20XqG8c8XhzIQP2OO4wYQrJcnj?=
 =?us-ascii?Q?nIgHt91IFVg4A10jqj4tJTvD5O2DbvATWmBetzagcMr8z0oAk9VoTTPL2TWA?=
 =?us-ascii?Q?2sShQ0pY8I7kKmjyBsbEU9Hk/zBbtT/cyD7vi6YPKnLG4EnBKbmvZZu9crsM?=
 =?us-ascii?Q?rj+HJqTgrisAeOqJOy6UcXc+098xXtzgkcHRtRagfyFrXKq6Jbv3Q9wlNNyP?=
 =?us-ascii?Q?NyDMvx8WNCU5TsC0tPbEtBcM2ggcjiFB69+V5mzqvNO8n8ThMWJi9UW32jLn?=
 =?us-ascii?Q?DawTErUUoGbPNfboQDUpdZ9PC6syrBI919oTmcYkxxRORHBNx9b8gS20Q/86?=
 =?us-ascii?Q?7T2V8v8xvKfvm1zyUJ0SQx+zCzSkRoS2ZbjXm6kglOypfRllfYyDqZCXZOtp?=
 =?us-ascii?Q?YqdkM8QXnrfrdib+qPSuHDVJ3XJBT/H952juCCos8vUhUjPn1XFiMcgOWvAn?=
 =?us-ascii?Q?GonK5CfI8NEH108n92c2aumLU2Mlo3rnym1oxLliru7d2vP+q7CxJGZ1p//f?=
 =?us-ascii?Q?d4rDDpLsWG4kmDhb4iFhj4S6yMGIEvJ9BPBrtv8VD9qTYW4GTCmy1BS8m0Dr?=
 =?us-ascii?Q?0xT+37o8qcBU8uX5rV4jdwyfoBABCfgdTLUTKcRMCv/IjBuNlwfX1h3YqK8p?=
 =?us-ascii?Q?+yoON9gej8PU78omwkOT6d6ISq8t6xFDSv01FcfqvpuKRJK/BFEW3FwfRchk?=
 =?us-ascii?Q?f7GK8XXtddDdF6UbRfxzBVTq0Gk0oQ+ZvHI0O+9pGuDsfYC3rvLmAc5XGonN?=
 =?us-ascii?Q?a14F5ShTR79xdEEZLXWxy6zbfzD2b7TYDYLe/mxrbDvc4GmyH2Zl+u7S4ViA?=
 =?us-ascii?Q?ye00rJQT8i4TXy0VwSJCThD1WzLJeBDFzV5EyDEKJBWGEO+EsoVmbEFoglKm?=
 =?us-ascii?Q?+kzORiLPPfWEWJfauaEFwbftpfOSuoA7+xhde/oJSJOxzkgoRxFISN6laRpx?=
 =?us-ascii?Q?auNnllmVr2anD1CyzBEk7bgrD/pFB3voEsuQEmmAAphUR+l/FDDLzz/SLiIn?=
 =?us-ascii?Q?9RwKK6R2HiOhLVovwD++cVy9p1/c9MVSqwG7muQRrWh9hN8tw05TWxEW2kah?=
 =?us-ascii?Q?Y5tfXMruktbVhPnsppQfKmnRk7XvrgzHBPKFMHqfjNPmavivq34OLnuADCeg?=
 =?us-ascii?Q?Bz+DJXpxffutR30kouHIniqfB6FNlzEBIntH4tt1Wn9iJB488IYFEQGLKcEF?=
 =?us-ascii?Q?8jb/qrM5QodqRDlFUNZ0JA7te/HgnKyHKntXxhvQjKaSPwchh7j5x+9UxI5F?=
 =?us-ascii?Q?8y47rEoz37Q2hHJFLkANk249afkyA5Zb0WcruED+I//fT+4cBe/0Ozq6aYxz?=
 =?us-ascii?Q?sNb6iOj4GzUVN9FZnFJcOvaAuIcU2kIv5/oBraBdQjxjeln1oFBXyqkePUk7?=
 =?us-ascii?Q?leTiIlwapBncslUhKfvjCvDFhYiL6DiaMq7QDAe7Tn3pIfcFst8vFNDLOUWT?=
 =?us-ascii?Q?Br61736+eNMFUkkjwBw/+Gmipdpzft/uNYfxzAAmq9IMn//UhbNsxmmRIlRv?=
 =?us-ascii?Q?zD/xGUUG6QoyrqKZYxq8KX647tasWqzY8Pn8yxbN/PWR5vxD0+mE0LUsJbuJ?=
 =?us-ascii?Q?U/ncWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d16695-dd90-4ead-e5e0-08dbcdf4a158
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 03:04:36.5577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpJVlbV99D1dNHp5usW4jfuVyKFWDewxsbUbZWuPnuDmYrMaWnCNAPOrtnximdCbvpVgw5GMiT7ldLLeMfgZyJoMWrXoRNxKhj7B3OktPa2vxFxOkGezM9KlGmJEXoq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8837
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Sasha,

Thank you for backporting the latest ravb patches for stable.
I found one of patches [1] was queued into v5.10 and v5.4 [2].
However, another patch [3] was not queued into them. I guess
that this is because conflict happens.

The reason for the conflict is that the condition in the following
line is diffetent:
---
v5.10 or v5.4:
	if (priv->chip_id !=3D RCAR_GEN2) {

mainline:
	if (info->multi_irqs) {
---

However, this difference can be ignored when backporting. For your
reference, I wrote a sample patch at the end of this email. Would
you backport such a patch to v5.10 and v5.4? I would appreciate it
if you could let me know if there is an official way to request one.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De6864af61493113558c502b5cd0d754c19b93277
[2] https://www.spinics.net/lists/stable-commits/msg319990.html
    https://www.spinics.net/lists/stable-commits/msg320008.html
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D3971442870713de527684398416970cf025b4f89

---
 drivers/net/ethernet/renesas/ravb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/etherne=
t/renesas/ravb_main.c
index a59da6a11976..f218bacec001 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1706,6 +1706,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
=20
+	cancel_work_sync(&priv->work);
+
 	if (priv->chip_id !=3D RCAR_GEN2) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
--=20
2.25.1

