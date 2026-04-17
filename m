Return-Path: <stable+bounces-238387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIrxAgmc4WkQvgAAu9opvQ
	(envelope-from <stable+bounces-238387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897A0416401
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A45B30EB764
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440ED30DED0;
	Fri, 17 Apr 2026 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="pAO107fq"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020131.outbound.protection.outlook.com [52.101.150.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F012FF17A;
	Fri, 17 Apr 2026 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393092; cv=fail; b=oc49jGzz/p10BGJK4VcFSRfubXnEhgs0w9/VBrIBmTBXs1tjjRkGGDYCEGpMyMA3hgZJ2eKSmPlcO6jwlGNs+LE6y49jX8J5JxUZl/tYo8ydqZGsJPH5zJ6xsQwymnX+79boVCyF+Wi/oNVpsCxfQQoqlLKSXO8yT7hTvf086D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393092; c=relaxed/simple;
	bh=laR6ttD1wzgbnwa1Phe/5meVs6CsNrFIYzP/X+foO2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aaq6E7PMcCF6cHlh2eGY3R1ezFHMrUobuz/j++awPV8WlPmkKuy+sSOo+mKdEnM04UjQIUOEEdbXBKnoH6sfqfSEc8Xh+sGaS7v0ViwKtQHjLgPNGRWeeJBJx75ofM2cLIsQt5OG2xvdXiueKx4RPDZ/kTWo1JNIStsunv1Us5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=pAO107fq reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+wmLKBsSOWw9cphdC/5VjZrSbyqFp1SQAGCdZzicPrjjQ2pyvd6HG+c0rEcaFZd1p2VGJadAT1tA6Tt+X2FzyX04GGJxPbC+6Zhe/T/BxE0afbFmhACV8ruYVaPmK7WNSBchElBDq8kesR5d27MRBzYVT21+GV1UBqw4tPge6EOlsDqSXSNo/MEk/KMZLeHSfabNovNjq+c3sf/pX/QcJbnJy/99Qo1nw9/HuK4aGSacb+y3bEZLEfoptGUoxySxUMLNF26d0gj0CZuLlalgNViBfhTd5mh1I9D9c+tPSG7t648xMiJloqkK+cxO21GCPtN5s3mx+D3NQ4vX6sdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv+k/J2dQmZm4hQi3E4DqS7+AjypkjFftNqqcfwwdQk=;
 b=W4ZjOmyNBCE0tVhlLxKzR3i6wdcoFRHTyKp7MpSxIhjo+5i74zxENSL2L0JsrYsRviaBE00VWN8OyAo7unAPDb+lQOQw1vYtuVyJZEjOKinkZzDTtq3RKlpwZaV32VMN614nBA0UxIT12d/6gvd8jTCHSwF8jWt7eYnPbwNzIZjU2mjtMZB/ZMHTv21+AlPiQjCGLOmSbEbWMPrr4Os1TtxIdAPn28E6hMaT9U+SGHkxcfLhi6KI6ONmAfh7n+twCfM2WB9hzJZf+qih/lJ+nyc3b5YxaFYSCcsMldd0wXQplFcEDLuPBhKbnM604vE2QH81GPTIpZA1hBdLPgGCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv+k/J2dQmZm4hQi3E4DqS7+AjypkjFftNqqcfwwdQk=;
 b=pAO107fqAD32v/mGCgBcs/XDfDtnZS6nnn/MVBp6j+QBI8Rac7P9nLOEzjjjGL47SYDYDMekkFH7zH5jcly4rJGYMJr6wjurUSSS9lw6AoCjLSPrND5p+ujEL0kBj/1yJ9TkyqFJWx6JtFj9pAoaLFDPEFC7solz5rcIUr9FfBdB2ooerX8IQCkwVUJPmanT1Oa1hn6ipNHVmttPS2XlswuVCw4fEPuH2E0ctppaOdk6c77pjRIyVveXQzQ8uUN4mBuWcR6JPe98xa85IV5vZm3WNwrXd02dT/d6S4opV7YMmDpuIHjvizh6+PNHZG9apW+brC9HIto/duYF3e2YOQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0725.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:31:26 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:31:26 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "brakmo@fb.com" <brakmo@fb.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "haoluo@google.com" <haoluo@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "jiayuan.chen@linux.dev" <jiayuan.chen@linux.dev>,
	Werner Kasselman <werner@verivus.ai>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] bpf: guard sock_ops rtt_min against non-locked tcp_sock
Thread-Topic: [PATCH 2/2] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Index: AQHczhJK1Cy+sjUg+0aWxi6vB6CV0Q==
Date: Fri, 17 Apr 2026 02:31:26 +0000
Message-ID: <20260417023119.3830723-3-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
In-Reply-To: <20260417023119.3830723-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0725:EE_
x-ms-office365-filtering-correlation-id: 929d12a1-eed7-49fd-a81d-08de9c296c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 kqo7j2bchHMJWub9IcLj0h59o9Eea0MqQ5NYzhfLOueiX7zB/e+feDXuJZT0qpucz5cnzWCWTvUPzluB+hQGPlywVrkQLR1MrDNlktPN4She9kbiW6PGzZPyEfTbWi0tAlTx9x6xDLWAD19ziAafTHUSsDCmjwAXHVj52W5tpDR8sM6EGokKDWKVt+eZ+C9rGkeqHGZa874ZLg3ctWQqNUQ8aMm3BCM8jWWxYGqzF+OyNKu4cSuOV784BzW13c3+Hn5lbH+Fg85chTX2e4JHpj7fpvOkYuF3Bn/P4/0FBZZgu1/7pluB/lljMNuaxuknyvmYWsqC4OIyuxQuXy+u9ti8KTh6MfkgPPeLAYKoHHfAWMOnsyCp5ZyIQh5LGhLvN4X8EDsCgbBO/KrOEYtLUrwBfs+WW9+J5ggRWGiWhJnk8rtGoAiUmAV3w+6LsEZy62mc0L1rBwJH1kZl0U8I+RN6zWrtHuNzDEK/y3CL0Uv4cAtAv/Ej7IdzkVcn3XY/UQyq6YZRKqZz2YFjDw3U9RUzB2y1OWTRxNWz593HcJ8QIkLSvHVFQES61S3ZGgYbG1iDmvRxCaZpmg323ye3driWwxVTvv9u4w2TC9msaR76KC3lY23b/pRAswkAyfvGjcWqE/yXHaqrVx3PokfYWPmYHT1KNYJ8WfGk3j8rfkULdXRZCYGLJsnrOGxJUuoX8wLSOx0IxWERME5DDRYDUY6W5GjvVyEVTTOK84dBUvmzHW6UJExfVunA5xYuScSGYJ+neXCUR/c+hxU/xVH5wb9kuMeNfQ2BPKiaYp/moTk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6BE51wnxxT4yGaotwJwO/5G1GzbRAWfuh7tW8Rpubfb5gyIMeVxpZpuy0p?=
 =?iso-8859-1?Q?9pOyaiSH5ZTJoqImCuMliV1JbzRuquHAKa1JRyk89kXWV9gAfc3k08Um5Q?=
 =?iso-8859-1?Q?CuryCtQghIta4ftSIZ5ZyKSzNTcg0+8u5y/eEMhkuBdCxZhKxqOv/cHb8a?=
 =?iso-8859-1?Q?iLqOsYcahBGeLILWB6LmfuW6DVtNnPXFsPZ65QzS0WUoJsBkndRtidMnXg?=
 =?iso-8859-1?Q?aYVAeNPcEzt6Ze3VKd969qtAQ+PklD+gyveZ3VuCv7Bc8GafRKjTXLQmtb?=
 =?iso-8859-1?Q?o5bD4YuBOFx2V7BL2lMaMmbtVxkOLuLTBHAOiEyg9+CO9x+Un34wRd5Edc?=
 =?iso-8859-1?Q?TS7o7CL7Zico/Dv5InzEvz0EnsPjJbe1qtnu3HUOaYaCcxv/PQznmJfeWi?=
 =?iso-8859-1?Q?n4RC1UJPswR00toq815vKnLhl9zgp7lor+P40gXyqI8JOdOK+sa2kD4puZ?=
 =?iso-8859-1?Q?K9d0WYdDhiwta3QffabJrujEiafxcBrPagJ9P9/zb0vbnHHksKke5I0LYj?=
 =?iso-8859-1?Q?VI8FVhaeDb78Yq2KltDPB67ZHqUyOlzL6a2mRNqUWO2uSXyOIxrn+o+shx?=
 =?iso-8859-1?Q?w0/QrnAuniavMtnpZ8qoNQ4euNtDJHApA6oLKOSLA0WJM5uik6ZbNQXKBy?=
 =?iso-8859-1?Q?5VzTSVUq5gJyyaDQfL76pWuQcVwc8Iyd6GIuFq4/ehkymrV5W7q/dYmxjo?=
 =?iso-8859-1?Q?HIGa2/vk5VfcbN7F3IHPikNfyDQIRshwCJmdH+AHn+ci3QAhj6DdJzKl3b?=
 =?iso-8859-1?Q?ByLyRAc+mqkU5vHjbhC1h0ot11XQzBnUhh0qR/XSkKQ7vF/Zy8WS7pSwIP?=
 =?iso-8859-1?Q?t070UcDhowpkbze265MBwbI8VjFZQDsN9GubnlkHA2CgKYpmMu5hBNWRWr?=
 =?iso-8859-1?Q?l5Ki05dW3GYKI8KA9DtneyMDRTY2M+Y98X1bQROK7zEyANMMPcmZwUyCy/?=
 =?iso-8859-1?Q?jEoAi52lMyXB49+NhkDE7XdElUT0R5chO7T+E3KDXeR3mU5ZOPQFwLSJmo?=
 =?iso-8859-1?Q?/cYxosDnQq1SYQKL42+rDK4clw2CijehvGztqtjNN9nI0dcM6RtJ7NpYeD?=
 =?iso-8859-1?Q?o1wrIKult2GXkCt+rRaZTXUd/ywUA+klE701Nx6F7LPY762YByQqMU1ZKK?=
 =?iso-8859-1?Q?oPRRgI43pbTkCLHWGWA0N767bYlf2gjqhuWIMvAIKjvwOzRexjiRjzPI8e?=
 =?iso-8859-1?Q?QrlTIrVAlpe4gveVFh2IpcYCY6sw3B976DTIczjWwGOxudD0Mt0VcjHrL1?=
 =?iso-8859-1?Q?jsxTn4x74to7OKdmr2W+xGdx5D3Sh9lIQZDP+Uq2zpm+llw4AgOxDJ0c0n?=
 =?iso-8859-1?Q?mO7LDUUIgG6IE8/fCTg2CLIVgMSde+2UxCQPuP74hEmYLD8E70WQciokrT?=
 =?iso-8859-1?Q?RhQ6107HjGgOOaA6M5yRXILmN+Jw1o9rv2+3c1KbwWoOMXaJbYLUfwM76c?=
 =?iso-8859-1?Q?v5rsFKxZpl3UX6ljfvgT5/Jsbfbdpgsw8ONeW6yPmulaASvQc3sGOS96xO?=
 =?iso-8859-1?Q?UpuOhQg7l1RRJ7omGT4mIAK7Pl54W/QF8cGmaql8PyUrHsbLLHOcBVqK+D?=
 =?iso-8859-1?Q?AnqW04d+bGY1MafGXTNS9qq3A+uyz3u6MiK5mf8Up5KPx1a7/Ux1WfFTdj?=
 =?iso-8859-1?Q?Mpp1mQUob1wu+M4HgWiHJ52i1er04QGKb9mGFDueRMflWN6ZCjWKEDCAe8?=
 =?iso-8859-1?Q?Q0wAGYyXCCGfabcO1X/PguXH00edVPI8f8H0Us31eYbkhA0JXqraY+tOwK?=
 =?iso-8859-1?Q?asJZh001B8AUHi2PuSq6cbBpiqpzAmlDr2zHm14auTRawq092Za9Bxj/vQ?=
 =?iso-8859-1?Q?DhzJyg4nRw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 929d12a1-eed7-49fd-a81d-08de9c296c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 02:31:26.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuErOW9uh+REKl8ZjtDIzmGRDk59oBGLqAq//xnd0yAv47nqcrFODIfRkxC6PfZJ8TN1pkZksAJPgitk1eZ/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0725
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238387-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,iogearbox.net,davemloft.net,gmail.com,google.com,vger.kernel.org,linux.dev,redhat.com,fomichev.me,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.203];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,verivus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 897A0416401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() reads rtt_min without the=0A=
is_locked_tcp_sock guard used for every other tcp_sock field. On=0A=
request_sock-backed sock_ops callbacks, sk points at a=0A=
tcp_request_sock and the converted load reads past the end of the=0A=
allocation.=0A=
=0A=
Reuse SOCK_OPS_LOAD_TCP_SOCK_FIELD() for the rtt_min access and compute=0A=
the offset with offsetof(struct minmax_sample, v). This leaves the byte=0A=
addressed unchanged from the old sizeof_field(struct minmax_sample, t)=0A=
expression, while making rtt_min consistent with every other tcp_sock=0A=
field.=0A=
=0A=
This also picks up the same dst_reg =3D=3D src_reg handling used by the=0A=
other guarded field loads. Extend the sock_ops_get_sk selftest with an=0A=
rtt_min subtest that checks request_sock-backed !fullsock callbacks read=0A=
zero instead of leaking request_sock-adjacent memory.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c                             | 12 +++----=0A=
 .../bpf/prog_tests/sock_ops_get_sk.c          |  9 ++++++=0A=
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 31 +++++++++++++++++++=0A=
 3 files changed, 45 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index e8ad062f63bc..9c43193a5c39 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10827,14 +10827,12 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 			     sizeof(struct minmax));=0A=
 		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
 			     sizeof(struct minmax_sample));=0A=
+		BUILD_BUG_ON(offsetof(struct tcp_sock, rtt_min) +=0A=
+			     offsetof(struct minmax_sample, v) > S16_MAX);=0A=
 =0A=
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
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/too=
ls/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c=0A=
index 343d92c4df30..1aea4c97d5d3 100644=0A=
--- a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c=0A=
+++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c=0A=
@@ -70,6 +70,15 @@ void test_ns_sock_ops_get_sk(void)=0A=
 		ASSERT_EQ(skel->bss->diff_reg_bug_detected, 0, "diff_reg_bug_not_detecte=
d");=0A=
 	}=0A=
 =0A=
+	/* Test sock_ops rtt_min access in !fullsock callbacks */=0A=
+	if (test__start_subtest("get_rtt_min")) {=0A=
+		run_sock_ops_test(cgroup_fd,=0A=
+				  bpf_program__fd(skel->progs.sock_ops_get_rtt_min));=0A=
+		ASSERT_EQ(skel->bss->rtt_min_null_seen, 1, "rtt_min_null_seen");=0A=
+		ASSERT_EQ(skel->bss->rtt_min_bug_detected, 0,=0A=
+			  "rtt_min_bug_not_detected");=0A=
+	}=0A=
+=0A=
 	sock_ops_get_sk__destroy(skel);=0A=
 close_cgroup:=0A=
 	close(cgroup_fd);=0A=
diff --git a/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c b/tools/te=
sting/selftests/bpf/progs/sock_ops_get_sk.c=0A=
index 3a0689f8ce7c..dee07da8901e 100644=0A=
--- a/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c=0A=
+++ b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c=0A=
@@ -114,4 +114,35 @@ __naked void sock_ops_get_sk_diff_reg(void)=0A=
 		: __clobber_all);=0A=
 }=0A=
 =0A=
+/* sock_ops rtt_min access: different-register, is_locked_tcp_sock =3D=3D =
0 path (TCP_NEW_SYN_RECV). */=0A=
+int rtt_min_bug_detected;=0A=
+int rtt_min_null_seen;=0A=
+=0A=
+SEC("sockops")=0A=
+__naked void sock_ops_get_rtt_min(void)=0A=
+{=0A=
+	asm volatile (=0A=
+		"r7 =3D *(u32 *)(r1 + %[is_fullsock_off]);"=0A=
+		"r2 =3D *(u32 *)(r1 + %[rtt_min_off]);"=0A=
+		"if r7 !=3D 0 goto 2f;"=0A=
+		"if r2 =3D=3D 0 goto 1f;"=0A=
+		"r1 =3D %[rtt_min_bug_detected] ll;"=0A=
+		"r3 =3D 1;"=0A=
+		"*(u32 *)(r1 + 0) =3D r3;"=0A=
+		"goto 2f;"=0A=
+	"1:"=0A=
+		"r1 =3D %[rtt_min_null_seen] ll;"=0A=
+		"r3 =3D 1;"=0A=
+		"*(u32 *)(r1 + 0) =3D r3;"=0A=
+	"2:"=0A=
+		"r0 =3D 1;"=0A=
+		"exit;"=0A=
+		:=0A=
+		: __imm_const(is_fullsock_off, offsetof(struct bpf_sock_ops, is_fullsock=
)),=0A=
+		  __imm_const(rtt_min_off, offsetof(struct bpf_sock_ops, rtt_min)),=0A=
+		  __imm_addr(rtt_min_bug_detected),=0A=
+		  __imm_addr(rtt_min_null_seen)=0A=
+		: __clobber_all);=0A=
+}=0A=
+=0A=
 char _license[] SEC("license") =3D "GPL";=0A=
-- =0A=
2.43.0=0A=
=0A=

