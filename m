Return-Path: <stable+bounces-240013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GITcHSuw5mknzwEAu9opvQ
	(envelope-from <stable+bounces-240013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9E434C3B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3389301BC26
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BF38B133;
	Mon, 20 Apr 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="YJdmuw+c"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020128.outbound.protection.outlook.com [52.101.152.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE5346A0D;
	Mon, 20 Apr 2026 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726042; cv=fail; b=ks6UdzWuAmtAzrp6MHqyO3vdjkLznLWqgl4MgF00CzykxA6EN3sMRtAklZgpBtoCNurAcwJ2883qCtkMJ/PgYjQAufvN0NOZ5PRsB6ySF40pM6wFy9U3q2BxOfkJZ2RPuIiDHklbLKfHt+sd6Rwt9p9Z9UIdLh9GhnJPKBqfjYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726042; c=relaxed/simple;
	bh=H5UAgjHf9uI82jAHCu5sWb5x9v/l4kLKUsUOJNZrRI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qCtHis4EH98qn5JjHKDiGh3lJq0aERt2alAHToPuAetqrIBCwDifCcPyvX7T81ZlVkuGUVR+ffBoMfbMyDEbkBst+jp3mizbh1jXQcVyKsfJ2uDHAHutCkYtT+jaTRmbCHJLTEp8X+pjRV7r9zv+TTKggUOTUjd8zS97L1+Mam4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=YJdmuw+c reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKpTZvk1pL3ihhiefcCFjL4cVoVhaF3/ijXsbS0XbzHsD1qpxjSJPzPzvgka/6pja3TuCIG8CG52Nm5iyKCfKSjIbo3NEwqe2HMhicvFFLUT+j7AD71AVJKsIEGJIC3e4a7OSVanzRziGpLx+ekXKWX4ePAzn4tEARxW5dmfLoKkE6SCEzhZ4OlCJW4AShvz6wACMUyAPzBv+LaqTI6jy1xcA7MmwYsxdpNYizV9ocM1EA20/RgsyZbHYJsfNys/4PoQOXhb8iFGFxtoENOH0BQpjQp6LnY2QAEt9GwdRHWI0kRfxWadjpmBYxEKtXv6Anci5lFkMtrqq3p/o+fGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgSKX2JGb9pbQxxbM5Vsgw7XCqtN44RD5ubLAVD9/Vc=;
 b=WtWv0LzwgslfT8AxqRLf1dQziHTbc58XTXYuedbSVmYrcojOR5eshNcuTMRz3aBLa2tJymO9dj9mo/aaX0D2uEACU2ndyXP5KmJ/QaLMYabmK7QKUWyf0qkNpUOUxJ2imizYjyfzCINbbNYasr0p0CvErH3R3MTbvTTDofgB8QjWvhp4aUHGhlNaT3FknS5/FESAYZJGEu0l63rvUh0FgCn5Lgj1Yo31KjWYELibJoDutzjfBLohPivnXfnMv8bj+S4QHYBezZamo2kZKOoLQgyMgqYFtoba+g2nv9j7kDmvND5yZfBugcDYAdHMX5tYRz4ZWo4b7WL/otpVGF4STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgSKX2JGb9pbQxxbM5Vsgw7XCqtN44RD5ubLAVD9/Vc=;
 b=YJdmuw+cJRGCOMPyxuHjeceTTCf36Kbk+8ohGogb2AYIG2xugJHAHjPqJHVWFz6dAcP+LPetlcqNezfulEep/v3RZ2jmm1YvxKO5zb1DA0ArYF/+KQ+m01MenRXDve1NLZm6TLWOBeTJfX+FDzva91/IsIMlZ/ypsTRS163NgDHkETe3WLUlsjRs7fY3L57QHkMu14hxueUQ7szXVSH6JI8i9O+ZQgLK7NX0Ck2vtJdL2f6dCzosx21MSyCAPqUvHa0jgkiNx4YqmO5U54J57VJetYap8uNA77QcEOl0MRyj2jBWCZdAcqD2gxu7oRBFxRnkLXUR7gsGZt4c1mwGsw==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1562.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 23:00:35 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 23:00:35 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Lawrence Brakmo
	<brakmo@fb.com>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf v5 1/2] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Topic: [PATCH bpf v5 1/2] bpf: guard sock_ops rtt_min against
 non-locked tcp_sock
Thread-Index: AQHc0Rl/8WgPcQzHMUKTt2q5fhMTww==
Date: Mon, 20 Apr 2026 23:00:35 +0000
Message-ID: <20260420230030.2802408-2-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420230030.2802408-1-werner@verivus.com>
In-Reply-To: <20260420230030.2802408-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1562:EE_
x-ms-office365-filtering-correlation-id: d2a2decf-e2ae-4184-e030-08de9f30a197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 tO3A83oW9wnfDUdV2UTA+mgyan2F8ZYy/oI9htJutNN+z1PmWIzTx7OINYobJtJLduwcdfkdJIu9a9gajtm3dAiHZ2DlFMwFPor5VOWMvo1ChR+KC31IenHbMlF4xaXCG1jJiL6qeq7gxQAYBFFCWI0XMkLxRKlOmGxmaCumURC+Fiie6JdIui1ycaUnpwjYVJk18tlTKCBI+gEn+wqJqx5sBHHrvEP5VUEhBCjAFlHGGV4r7iqGzfFMl5BoOIRBJDA6zsgdpjxCqBrx0jbkYRBoCUxnNvLTJ7P9YaQqYqgww8HqsrwrMKxklFPy7dgEHkw5r8tCK1FBqW9uPih9Q3cpaorF6Z7q2k7ST1wd04oGwRYhVrmK9PmtUDVJUz3HeJL8qcnbOt9JBFMH9KS9D7dIhJQS6puCcPsGGzlMca/UOxbes99Eng8ZRMTVIsvgiVPnZmt9SoJgHUpxQ6iQreO0ixUGjSTeJ11B/HS7lCntVHhfHtqMwsuSxYHdWwB4nNC4XoJUWdsWlh+E964XbpppBTkHNRDskZTJYBo0eEZum8IktfjxoBs5rVv5zTolNh+LiDyuRFcpQTHvp5p1pMrhl4bnZ9KVa52S2IwZTVKUHDjTOAdVTlNrivliYBKL91RzBE94Y+mM3SBBZLpoy0+1vuTiF2z/E0NBvVzW5QCtqguuuuG+LjEKNvPg6as23weeWUp9i+41XuWsMnQFRks369L05w11xHk/2vST85j7VeTBYvw0Kdrk5Co4rLAJhEBOJsHmHXakQcJkdUX3q4q/5P/MNHqYtL0Dk2d1PvM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0ClBA92wpqBTarYGf6EsfaFWcQYxWdYDCwUPdJSbQ4/2UcxC/913MtgF7J?=
 =?iso-8859-1?Q?TCeR4AOP0ZZoAMaq0ah2HrfkvlcyhMe4ER6fJ2tmsFsfFLxCENvCpY7pop?=
 =?iso-8859-1?Q?reSvnY/qrqICLkh4F6tjrs56d9i+5ReaQPr76BusjOr5/ImL7qHdsCo/5N?=
 =?iso-8859-1?Q?+vFjl0ehdwtFOTRZ1gLX9U2Ams475uzJ8VTy9LmJDXVgiKnB1V4Q6cxiQf?=
 =?iso-8859-1?Q?tXtHYmdt9oOOnxQ1DKOT/Oz/RjAOyKoh5o29gS8oDc1EV0sNye3/rxZj1h?=
 =?iso-8859-1?Q?n+N+K9+hnZ8Wsu8cmJM8StyLzuRfz5eQNWxhEusDOlrgrdQYfpo/EJR2GW?=
 =?iso-8859-1?Q?7oqiFlrGcPp+Qsk1PEtqOPmovKcG8t5Znd56ZJPf6YBdiRj5aUJTJ1PgU5?=
 =?iso-8859-1?Q?NCIdJkHyP0OG2iam+4ES+zlxINyXhLaCNCZ9mLAbOT1t+Wu9JkP7ANfP8Z?=
 =?iso-8859-1?Q?ioMfY4OfUs6KSpfXK+BoMR1fTDFQ59roWAsmSThFufU+5jBL3a0HAsMw+2?=
 =?iso-8859-1?Q?8YqL9ZHZhH97n8vQ7JGsY36VeqS4J4cfPEhnqDOyBuAgwJNVsncOCXljUb?=
 =?iso-8859-1?Q?B4z8pF5bmRMZH67q6nuOxzh3Uls7VBD6rSU80r78MkHUFLxRWP0dI4vd2z?=
 =?iso-8859-1?Q?Qj5tGRjXNgwcRZwSsaj4GgIWq2a0HZg/iuecjbxbQQYq5bwaHwu/j0NRNc?=
 =?iso-8859-1?Q?8rNGFxoeFZZCKWniE6QODcxtWQnUF0T9qkdc3286HUOcC/PA3K2SYb4C7Y?=
 =?iso-8859-1?Q?wheHH6pNcc31Url4Z9zKHdGRpBRsXQj9oDxM7BH8qq7mekFeghLwXcyKRg?=
 =?iso-8859-1?Q?vFLjPMwRVBYO0loQ9kNcJ2j88iGg3kn8dPWdv21LKGY0kFBnRfkMHPgVAy?=
 =?iso-8859-1?Q?4q/4Yg+hE6q/y6J2Qq7kVOuKeuFSHnf4SppIA7nBKcec8P/tGyPnQVBpqv?=
 =?iso-8859-1?Q?etiLI3k2zJWFoF9dumsC0WJWAKv6qOumsNPJ9OP795puub8GnT3Qft+eNU?=
 =?iso-8859-1?Q?voHiV8TtbY7topk0BSzv0pj3ni9IjULLvtJmOJhA8coFX2e3GSTtnJrG+5?=
 =?iso-8859-1?Q?sTTNNxREuwffTABDQpHyB3Sj+8Ca0IRHEtyu+jcWm1udKsfL7lmx16H3ku?=
 =?iso-8859-1?Q?YO1gKOvdhlQ+eXXwAXklwlpOi9BLBBv4mJA7x6CfC5mkYHKZigJ5DsL8fJ?=
 =?iso-8859-1?Q?jm+t11mZFLeFMgLYTMLB4fF4tZ9mkGI0LeqBSY2YYEyS4QoLVQ74DJKinr?=
 =?iso-8859-1?Q?Iht/Zc0hBNEH5m8ReshZDVD54KiX1TO32iluen+SD+JU/1ug5SvcXUP1xq?=
 =?iso-8859-1?Q?aBUh/3L3bzmmbb5B1fIAV4fBURSsv7jTsPPCQJ1eNT8cEhCh/7lCm3Nvjw?=
 =?iso-8859-1?Q?XfeEtzwhKAS5s/TdqyaD3GbBvJ067DF1s6fjGzluObHHZOS3ZrfQWMEvYo?=
 =?iso-8859-1?Q?mOVa5LURISERIN+B7vlv+6q+CvmhQ3G/uxnDwT5TDhNMFur2TJb11SRWT0?=
 =?iso-8859-1?Q?pMsFPNTXMh65VPokAwcHCIVNB4vUDIhIswKySDH+qYb8jNQqcD8PLvpc+4?=
 =?iso-8859-1?Q?jF0w0s5fcMdzdIXO6PcLsHSIDlDHTq6PC8RWAmzKHbqGu3hDvnQxtlNuY6?=
 =?iso-8859-1?Q?NXkTKbFtvz7yHMT9uqRyjfRC5phgvUNCxW8zykOVnG16HXEkF49r5BpIMM?=
 =?iso-8859-1?Q?3wtnDafxX/Ge4b4aoak6my8KBcrSjBqj2QzKFPQdI4vd3ktS6vK3OVudAN?=
 =?iso-8859-1?Q?J+E7bulWlaWj2B5y1ANavUQC7kfEA5yiPAWQJVSRflsSH02K4849YfbJjf?=
 =?iso-8859-1?Q?E7a3ahNCEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a2decf-e2ae-4184-e030-08de9f30a197
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 23:00:35.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dum4xsmsaWJ+2fLQx+YBmSikR0+0u2otu+NAfPur+i9siwLX6mS1OE20dJBUT19CY76/xcdA2oN7isZz0yJSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1562
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240013-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15E9E434C3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() reads rtt_min without the is_locked_tcp_sock =
guard used for every other tcp_sock field. On request_sock-backed sock_ops =
callbacks, sk points at a tcp_request_sock and the converted load reads pas=
t the end of the allocation.=0A=
=0A=
Extract the guarded tcp_sock field load sequence into SOCK_OPS_LOAD_TCP_SOC=
K_FIELD() and use it for the rtt_min access after computing the sub-field o=
ffset with offsetof(struct minmax_sample, v). Reusing the shared helper kee=
ps rtt_min aligned with the other guarded tcp_sock field loads and preserve=
s the dst_reg =3D=3D src_reg failure path that zeros the destination regist=
er when the guard fails.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 36 ++++++++++++++++++------------------=0A=
 1 file changed, 18 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index fcfcb72663ca..2e7c33d00749 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10535,12 +10535,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 	struct bpf_insn *insn =3D insn_buf;=0A=
 	int off;=0A=
 =0A=
-/* Helper macro for adding read access to tcp_sock or sock fields. */=0A=
-#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+/* Helper macro for adding guarded read access to tcp_sock fields. */=0A=
+#define SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE, FIELD_OFFSET)		      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;     \=0A=
-		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
-			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
 			reg--;						      \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
@@ -10548,7 +10546,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_acc=
ess_type type,=0A=
 		if (si->dst_reg =3D=3D si->src_reg) {			      \=0A=
 			*insn++ =3D BPF_STX_MEM(BPF_DW, si->src_reg, reg,	      \=0A=
 					  offsetof(struct bpf_sock_ops_kern,  \=0A=
-					  temp));			      \=0A=
+						   temp));		      \=0A=
 			fullsock_reg =3D reg;				      \=0A=
 			jmp +=3D 2;					      \=0A=
 		}							      \=0A=
@@ -10562,24 +10560,31 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 		if (si->dst_reg =3D=3D si->src_reg)				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
-				      temp));				      \=0A=
+					       temp));			      \=0A=
 		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \=0A=
 						struct bpf_sock_ops_kern, sk),\=0A=
 				      si->dst_reg, si->src_reg,		      \=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));\=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(OBJ,		      \=0A=
-						       OBJ_FIELD),	      \=0A=
+		*insn++ =3D BPF_LDX_MEM(FIELD_SIZE,			      \=0A=
 				      si->dst_reg, si->dst_reg,		      \=0A=
-				      offsetof(OBJ, OBJ_FIELD));	      \=0A=
+				      FIELD_OFFSET);			      \=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
 			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
-				      temp));				      \=0A=
+					       temp));			      \=0A=
 			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
+#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+	do {								      \=0A=
+		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
+			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD),\=0A=
+					     offsetof(OBJ, OBJ_FIELD));       \=0A=
+	} while (0)=0A=
+=0A=
 #define SOCK_OPS_GET_SK()							      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 1;     \=0A=
@@ -10822,14 +10827,9 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 			     sizeof(struct minmax));=0A=
 		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
 			     sizeof(struct minmax_sample));=0A=
-=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
-						struct bpf_sock_ops_kern, sk),=0A=
-				      si->dst_reg, si->src_reg,=0A=
-				      offsetof(struct bpf_sock_ops_kern, sk));=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
-				      offsetof(struct tcp_sock, rtt_min) +=0A=
-				      sizeof_field(struct minmax_sample, t));=0A=
+		off =3D offsetof(struct tcp_sock, rtt_min) +=0A=
+		      offsetof(struct minmax_sample, v);=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_W, off);=0A=
 		break;=0A=
 =0A=
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):=0A=
-- =0A=
2.43.0=0A=

