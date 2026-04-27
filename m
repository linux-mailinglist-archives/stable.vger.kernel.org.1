Return-Path: <stable+bounces-241363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOYZDA2I72mtCQEAu9opvQ
	(envelope-from <stable+bounces-241363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:00:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AA475D3E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76BF23048A0A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842533554B;
	Mon, 27 Apr 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QJ5ErbFf"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43705312834;
	Mon, 27 Apr 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304593; cv=fail; b=ig0esrdli7Wf5Pghfi5XozpXQzB5ekdaEjpjDceb7Vu6yf1wvonBzuVu6djqKdu0SAN5aSZPRTEGQg1gP1lWC89kmDfgdi3ih9bhhYY95cB0FbTPQFOH/+uRwcFihu36EQUUyZue1sfYgED7IteC/IAMf9MSl/MExfaT6nh2N6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304593; c=relaxed/simple;
	bh=0blpZv/coeux1RVOzcgtYZ5y4eZCDF5TiNXxv/HX5hk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jHZUsCQIl61g5UIQjRwPpTsEl4FQcVrFhUQNB19SeZR4d5ggQKar6dUo59pkpfcwSBhFeMwZwGaknUM/wlQcRVrW/pspExJLDYt4OijCLCWdmClUzNwFNX1zaoGBrzPxIpa4HqQWwC0W+yOGNWmLhYUXQOBZ0MWHYrj6ij1CHo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QJ5ErbFf; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjaPJlH66PXUb9aIjB6pGq56mxmsFaU2fxFrNAGgistk4MHCHx6EuhlhBGMAhuBAi882ZnGRza5FIM5d6dsHmvBFd28dxbn/fumXLubOT6ppuvUJIv4T524441rL3aj5U6KdygNW0QXO7Rcxjlrr8A2WRpIv4GNoya7cb1peqFe2QEV26zBf1esBbcZWEVMKyDn1vo2UFOHH4l8Bc4UFgQ5kdfZ4iHA7zGteXXsX4PZh8lCXaw05rxaOAxnIcJn9ZS/F+TcVMVn/+f8dwIStPmDnkeAF0omR55/qFvLUZy8/JAMLx5OA6ZfkSVud0g+dtVEX68hcRejI7MCWzG/Q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xVbElnx6NFCqfNZOr065WM1AXDpJCruX1BAfza/CkM=;
 b=oLXRTdjVxzvyGnfrMODhqayQ0Tdl7jQZeCx70YJVW/JTnL9+m2mOA2nAiFuSQ1me6tQAIZa/yE7wswUEGH8oGvQVKKx2GvUuYwOvaAJrXxgZdgYwexCUSynrsDe/jFxBgZiFAZIYei1iIObfREQcZ+3Bc895miQmrkBpZgc/BwV5S8t9qOApQUVVwdemBct5Pm9icHbzR+sYEMSbhYGWJrbdZrI3RWTbksQbkBnNXy0ogKhWZlHLyvI13hEj2RN90qdNbLEGO+ufdhuO3oRlYsEd9cXHL7Fvl9EmfGxQYUDvTLQxd7QXExLFJIYIC0NlcQ0mU0HgJhhAwF7kQd2QsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xVbElnx6NFCqfNZOr065WM1AXDpJCruX1BAfza/CkM=;
 b=QJ5ErbFf5iE0ovki6CHe9A6FwxI+uxPLdfpbnMKcIYK9ENUsA8y40cGE7MS2TzgF3+G8/jzZ74HeIn4UURfQ5KQT6w7m3v5lLSPSIV2fhGpsLa9f71CuDWyoXi6sXtdw73qLf1pYECSbV+/h7HQ2oX7KrtXb554y0zV4wuLzb2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2114.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:43:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:43:09 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 27 Apr 2026 16:43:00 +0100
Subject: [PATCH v3 1/2] rust: pin-init: internal: move alignment check to
 `make_field_check`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-pin-init-fix-v3-1-496a699674dd@garyguo.net>
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
In-Reply-To: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777304588; l=5521;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=0blpZv/coeux1RVOzcgtYZ5y4eZCDF5TiNXxv/HX5hk=;
 b=EECnyNAdq6NxsaGnmdYFTUVcGTCaTrT1x8SePUB+i5msQSIGN9CZdEu6EfjhacG0b2NO/RXMT
 Osqem8xF8RGD3zXE8q6OzB0u8XRA2rHAG0/c+wjdNOknZECf6Sr8181
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8b6b39-2b8c-463c-38cc-08dea473ae7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mnRmtTuXFBeVOWLKrEtOPTIndsoz1UnHbGkNU45WBFSOvWKFMKh9KoWG9sxTrM6H5uGDdt8gP1dtJBCb0foY8x0O7DxfXQbasiUr9oI3Dxlfw57mPhvePUHszmPF9GI1FbNtqboLeqqMM0U56xqBCP411h9AFNmysNTDRU/nf9IEoO0BStIrwEvcXZwakY9RPkrZjbwQ52CkuWfrT/8K9gdJxslkqE54wvhCitTVCjqfh0o/sVS3SpfiyzQVPTZAllngqWO+ZnpvifrXQvl9WJ8VTfmuFcMmUY45cNej6/ROBzZR3ipvND+iiix0w0aU7av+lXfPEKvqRy0aXQItihfeB1tCu5SRVZLuY0+dhudG/+Hu0JtPIydVTxI0583Zh/mMkni4XYNeeH4yHQSA/ZlsxQ5orDccVU483pIzj8VSy8rBS1NHsdzEsZkkrAzktaHjxCwH7uwtFL3u3oj7qrYuSnXumDN4+C+zGAF+QFETtO2hallSL2js2vIMhcIC1I/HRkhFCXDLJuB4Vh7ELybrhj7e++kZA8lnY4iXFVOXTZoXKP2pzudJskxHliaGwNq5UKS+QRKE1OpFjaSB7sxurGq7pAUOdiTaoNFmG/530/jvA5m/8HJPp1tflqPy2Vfcmr9Q1dnKp/AsIDTEBNp+mEVqCU16jSKOgZ2dqddl+jeWJh6Q+9Fldq1mFFEaQDxlt26Y4NJ3xeM3CqhWEzey2LHJMrxn551BwYwCzkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0dqOEUzb0VseTViL3htQVZQZVluUlEyK1lpNzYyMzZUcnk3aGJXWjgvVEtF?=
 =?utf-8?B?eDFnVVU4bG9oZ1BWWHVqL1Fvajd5WTMrdlMzUGRwdFJpbU5rSUpoMUdJVFF4?=
 =?utf-8?B?b3gyWi83Z3BUOXF6aitXdmY2THJxR0lmeDBOdEc4eVFGTW42RWROUGtpMkx4?=
 =?utf-8?B?S1c5Z0hmV3g0akt0MlYveE1PTUZ2eEJTNmlnb1U2ZkZTdXNBbUdncU83blls?=
 =?utf-8?B?Znc2QW1MSlUwRVRTekQxLzFjc2JzZ3hQLzh0ZlhoTTAyY0k1S3p3NWl3YWxX?=
 =?utf-8?B?N1RQMkptMjFSM3FjZ0xVdUdKNTZNQkhxWXBIZ3NEWVJHcmpOYVdEWlo5cUZJ?=
 =?utf-8?B?Uy9qVm1jMkljZUYyVEhXRUpVOXZtMlROVEVjbFdmUVliREVnWkJMOFJqOUZV?=
 =?utf-8?B?dERsMXl5SlFOWUZjbHAxWWJyTE10aTN3eDJuQzZWVHppYThzZWpBdUx6aGNF?=
 =?utf-8?B?Y3hVRXV6dll0ZUwwS29RaCsvcEdueC91cW1xakNBMnRBT2UwdWJMNy9CQ3Qz?=
 =?utf-8?B?SmxmQWVacXFKOFFaZ3VxZlF0SGNhc2lKSzlEcFAveU1sQS9DNWRxTHdtd25i?=
 =?utf-8?B?KzI0VFZjdkxjWFBBZ1FjU2R2MzVOSE0wQkpodGdaaWFUWDJiN2hpRHZwTFBT?=
 =?utf-8?B?VU0vV05rdnlIN0ZLaktqL3BnbDVpVXlyWWlrdWgybHpIRjRQOWtVcWtsZEtn?=
 =?utf-8?B?VTVlUTdtN1U1a1pUK1h3azdOOWFrUk9tc0VxTVVic3lDZis5UDViQkY2SXVN?=
 =?utf-8?B?VzZOL0NSSlpiNnlTZTczWlhBbVJCcEx0YnBFRnh4NndXZWlQVU5zS1oxWFFL?=
 =?utf-8?B?cUhGQnFZYVJUL2RPWkM2TDlKMzkvckRQbVNsUnZhdk56UHhZamlKNWxDV3dn?=
 =?utf-8?B?bjdGZ0xzSHZWb3MyU09wcVc4VzQvR3FUdHBSYnUzdjlGbkhzTGlaeU0rZHlV?=
 =?utf-8?B?aWZjODRvSzE5MThiTHpKTGtCdyt5QXJVOGFLZUpCSFdhbVRIRDRJdUJqNmFK?=
 =?utf-8?B?MkRMNUl2ekNjNFN0eDJqYXVoRjl4OEVNbGE0clNHcFFHV1ZSRW1iMkV1enc1?=
 =?utf-8?B?cUpTNUFkS2lQRXBIUndMVlh6NDdSTkNscjYzbkszK0lHRVRvREZ4NUN6TjJF?=
 =?utf-8?B?c3dzNlQ2dWhDamdYeWVSS0ZLYlRCdldrZGxyMENrV1A4VUo3SFV1d2o0dFln?=
 =?utf-8?B?YmJMNm41QUtudmErOEtPVUVrYWwxZlVhUkYwdHlNbmFBZW1FVkZxY291cVlj?=
 =?utf-8?B?aWNuaDRGeHVPSG1jZWVlc2ZIelZCbDIxOTQvbTd4YU1VM3hJTjhIVW9qbU5i?=
 =?utf-8?B?Qkd4NXhQdE14L3E4dkwwMFdyL1BwYWw4YlhsVHIxalVFc0J1Qk44QnljeDNx?=
 =?utf-8?B?dklZOGhpajhOazdTWGtlWmY1YWt0eDJvQ0VOZFBMRzRybCtlQ2FzTVJ4UE1B?=
 =?utf-8?B?REczZ3duNkM3Zlh1RUp3YkdPS1VSYTRETjlua2dLeXNxSzBiNnNkSzB1ZDZ2?=
 =?utf-8?B?bytBQ3p5UFU5MFlUeTdyRTBPQlB1Ty8rOEZmQVNhOUZQQW9qaDdTL3BTMnFO?=
 =?utf-8?B?N1o1UXdoUy9HY2E5S01kdnRPd2RZQU1RSmhmOTcyUmhRV3NYWkVhT0l0RWFN?=
 =?utf-8?B?V0laOElJYVBXYTlUbUhvOTBrTUdWZ0xvRGF4ZHgvNHUzdWthSDhPVXJ4R0Ns?=
 =?utf-8?B?SHNERk1vcWxSK3U1NDhPNzVyU1dtYnhTWGVXVDJGR2pucll2VHRHSXJvQkZG?=
 =?utf-8?B?UmpEMDZYYzZ3VzZoZ3JqSkhIeW9tTlZDYithd1Z1dFMrSXhwQVk3SHZ0VlYr?=
 =?utf-8?B?NzJxMEQ1dmJueG1pcWVhQzFwTDhTWG14ajc0L1pkZFNrdGp1NW1uekVqUmZy?=
 =?utf-8?B?clRrenBkQnhwTHFWNmU3b3AvTGEzcDBnNlZNcEpkQkc2bVNVZ0NCb25HRTZI?=
 =?utf-8?B?SVBjZDFLcURxS3k2eWpPNHcrZ0t5bmNBQW9vZHRCMmVnRkxDRCtVbFlOSE1u?=
 =?utf-8?B?RW9YTVB6RGVhNm5rQ0RCV0JUNVpNbUN1RC8wYzhjSXBPS0NwUUZYdFpUbXov?=
 =?utf-8?B?eWEwYXlHYVFVc3NubzFVT0pmZHo0bkxTZE91bEViVjE4QXR1OHNOQ0UwcVJK?=
 =?utf-8?B?ZlZsTVNvbUZkK3c0NjhwSTdyemg0MjFSTTdhQ1VXM2NjZUozWHZ5YU9lVXpy?=
 =?utf-8?B?ZE0wVjhycWEvT0NLL0ZEYS9nNURaVVRGb25UYnRHVWRlSlV0UnNWWGlIandz?=
 =?utf-8?B?aGxSSmE1dzdMNzFDL3Vvek1Rd3BINUVsS3NhYXA1VU14U0YybHczeXZDOWRC?=
 =?utf-8?B?N1R1alYxRmQwaDYwRnIydUpSTmdYdUl3WU1vZUZvbFg0NVk1VkdqQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b6b39-2b8c-463c-38cc-08dea473ae7e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:43:08.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOgkJVf7DOrqto2aaw4AYwmovaHLmLt0t9QeVFaOZuhTZsjBvbPSXcvi6hH6Q6s7P/3pzFb3zdhr9Il5Dqlo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2114
X-Rspamd-Queue-Id: 9B7AA475D3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-241363-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Instead of having the reference creation serving dual-purpose as both for
let bindings and alignment check, detangle them so that the alignment check
is done explicitly in `make_field_check`. This is more robust again
refactors that may change the way let bindings are created.

Cc: stable@vger.kernel.org
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/internal/src/init.rs | 78 ++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index daa3f1c6466e..0a6600e8156c 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -249,10 +249,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
                 let accessor = if pinned {
                     let project_ident = format_ident!("__project_{ident}");
                     quote! {
@@ -367,49 +363,49 @@ fn init_fields(
     }
 }
 
-/// Generate the check for ensuring that every field has been initialized.
+/// Generate the check for ensuring that every field has been initialized and aligned.
 fn make_field_check(
     fields: &Punctuated<InitializerField, Token![,]>,
     init_kind: InitKind,
     path: &Path,
 ) -> TokenStream {
-    let field_attrs = fields
+    let field_attrs: Vec<_> = fields
         .iter()
-        .filter_map(|f| f.kind.ident().map(|_| &f.attrs));
-    let field_name = fields.iter().filter_map(|f| f.kind.ident());
-    match init_kind {
-        InitKind::Normal => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned exactly once,
-            // this struct initializer will still be type-checked and complain with a very natural
-            // error message if a field is forgotten/mentioned more than once.
-            #[allow(unreachable_code, clippy::diverging_sub_expression)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                })
-            };
-        },
-        InitKind::Zeroing => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned at most once.
-            // Since the user specified `..Zeroable::zeroed()` at the end, all missing fields will
-            // be zeroed. This struct initializer will still be type-checked and complain with a
-            // very natural error message if a field is mentioned more than once, or doesn't exist.
-            #[allow(unreachable_code, clippy::diverging_sub_expression, unused_assignments)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                    ..::core::mem::zeroed()
-                })
-            };
-        },
+        .filter_map(|f| f.kind.ident().map(|_| &f.attrs))
+        .collect();
+    let field_name: Vec<_> = fields.iter().filter_map(|f| f.kind.ident()).collect();
+    let zeroing_trailer = match init_kind {
+        InitKind::Normal => None,
+        InitKind::Zeroing => Some(quote! {
+            ..::core::mem::zeroed()
+        }),
+    };
+    quote! {
+        #[allow(unreachable_code, clippy::diverging_sub_expression)]
+        // We use unreachable code to perform field checks. They're still checked by the compiler.
+        // SAFETY: this code is never executed.
+        let _ = || unsafe {
+            // Create references to ensure that the initialized field is properly aligned.
+            // Unaligned fields will cause the compiler to emit E0793. We do not support
+            // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+            // `ptr::write` for value-initialization case has the same requirement.
+            #(
+                #(#field_attrs)*
+                let _ = &(*slot).#field_name;
+            )*
+
+            // If the zeroing trailer is not present, this checks that all fields have been
+            // mentioned exactly once. If the zeroing trailer is present, all missing fields will be
+            // zeroed, so this checks that all fields have been mentioned at most once. The use of
+            // struct initializer will still generate very natural error messages for any misuse.
+            ::core::ptr::write(slot, #path {
+                #(
+                    #(#field_attrs)*
+                    #field_name: ::core::panic!(),
+                )*
+                #zeroing_trailer
+            })
+        };
     }
 }
 

-- 
2.51.2


