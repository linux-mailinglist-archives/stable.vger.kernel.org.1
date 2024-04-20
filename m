Return-Path: <stable+bounces-40349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8418ABCF0
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CA1C20A40
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44833FE54;
	Sat, 20 Apr 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEUjHDgu"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87613FFC;
	Sat, 20 Apr 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641919; cv=fail; b=uaMvumQgYU3fdR+2V/lLL52Ek+d9LnNkNDFehfvtge3ZN3dURSRS3ttIrkjHKS9SqlBgcVl68OoLbCg+b0YZ1SyvaN5KooCIPKWGqDmngBXhk/v/y8uRD7faMAGa1FDdCarekxY8Va43oqW72vbO1mbCyEMkHJX+Y/NhYO4QRXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641919; c=relaxed/simple;
	bh=Kanet9d84CFhjZMIjIi0JK6eWh7CT+Z4TbreT850Wg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LESdhFtCu+oizw8Rh0BEOxjLhIGnKitww6+VZmI/54xvUXCREJS3tGbMb2fmdh+y8+mxmRrgBsSOaJsDdPF8TDRbLdT8prszlrRHJBsT3ekPb9OnzOdfCCYY6OPwB2US9wbC2kw0pLDFU64kOapC5wgsZsrwY4zbgrAWd7tCrlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEUjHDgu; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/7dpMRnL74cv8zxFnrxeyuFKGyTLC7FtbTIrUTZYTz5kjTr7HypDUTmArl0Xk5LE+jTYOZDRspWnCXT8D/0HuHlmEy0JPGSDz05Gqwo7XNMNCJMHubgpQLRCQcBwwQRJ8YL+4pYIrpIGnYYbRXHpusIaHqQOiVGbopKsxqMAVXbyhDgwVJB+4XuPknAGMfSf4nRiRKW0z2flZcxFdUk3XqDi/be3HrO/asAlNnVlEZ9j6qvY/XFZVmXcX6K9iSWObgmUW7c6mefc0aSE73m6ieAsZbW8XiqoFO/upjz9G51KBr+U+pNxM6RrNas/d3KXSmSvu5aA5OjlBqXh7RI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyMQIfOF7fNWg/JUu5OHhKLrRvqxhTUhkN1i+tIGDcs=;
 b=lJCDxcmQzLXdw8VorJa+RG9UGs8KY/7oB6GmrEu2pxk9wSRgtY4yA0cngCrLCLlZP8Iws+XZrENNfiIPD5XpjVJttly8S63FHsIkv7l/+NfIfVQdjXA8+G/H50U+ozN6qbM/+qSVAXb7HnF7F0HaSP0D/JFE5xnMpYNXgbkcLxlZyka3kzAuUAJpL9EIDRssS7XrJco4xD45h1nMjoAvOTxpb0jClfO96/d584g8EFTVGCOWt3PCtK4Ok84OMFHpUqsLciLLetxk173QDvW7Uu2f9GgaXCOCCm34wzmF6Wt8sIJRd0YN4kDFf8kIC1GGS2jUm631Hf99UxEmgG4aaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyMQIfOF7fNWg/JUu5OHhKLrRvqxhTUhkN1i+tIGDcs=;
 b=HEUjHDguc79DyQgNolQWKY0smThn20WlbmfO45mX1fGRyYbVXizcZLjCBOXvTUFzpaElO62dsuNUAd0kGnsTZ0KCv+ycyQJd+3NnP+DUeZ7Wx9gnJ+xzfTzx0iHkzWFitN+r95pnF3mmMLHQfis8GD2+vwZKYHVm29fu4ZbTPIXBDgXJKr9yjKYZkV9JA8VCSbougWRfgE4uCLlcR2S82emVb6tsOUhyt2Dsk4F7QIYlLD9dWRPTpGUQYfvWpA1RI6oIT/xOqsxx0/rx4+cL66dikKhCgFzLOIyPXPnhSsjIyYv5SJSkT9nv8aQuvItpBRgISOA0VKxVcm5HUMcpMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 19:38:34 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e%3]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 19:38:34 +0000
Date: Sat, 20 Apr 2024 15:38:31 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 0/4] Fix isolation of broadcast traffic and
 unmatched unicast traffic with MACsec offload
Message-ID: <ZiQZt6m-KOcOYHqP@f4>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419213033.400467-1-rrameshbabu@nvidia.com>
X-ClientProxiedBy: YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::33) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: a70d578c-0171-47b7-6348-08dc6171770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?271Hitwu6i1izS90tsD2WXaP8TH5tMoUluj82RqDR2NG4BNdcGCrspx7lKCI?=
 =?us-ascii?Q?D0sTSB98yYpqRNnVuPNvzbVZgC7Vh+JVOjeP4h5C0JL+21lNBEV5wQXjxmEM?=
 =?us-ascii?Q?dRMYFWElA8Zl+fH7zNd0BW8GOhZ1ihcn8cheLP3UfOHJEwc9GKNQ0L3CPASW?=
 =?us-ascii?Q?Q3rCcSTxrl/qP8BfjHgBCuhgglVGd2vreHRnS0UXnZaRSj13ri0XYk76ewNa?=
 =?us-ascii?Q?xUWRrfpXZf4LC7dlhQ67sg5jKelNOrpjoI4P+HttwtUrFSOQ/gaCwlilhO7X?=
 =?us-ascii?Q?9rZiBmpwP++8x0JUJID5keV3gI9mrAvBjEFfWc+9FNy6/8gLOWNQlnqNCSRV?=
 =?us-ascii?Q?a4ZJmtD4Hnt9n4qB/3sj7jy92fqIzZvpKJ+/FcXp/JL9dSW+n7c4DrzNa/FZ?=
 =?us-ascii?Q?OqPKURsbZ/dFXucKskJfNLIprd7RxjDugwnTHilHqw+/Jz2OeiVmYb8wdRQC?=
 =?us-ascii?Q?BoN5KMnucIC8CSNFUqbKM9+kol1Em9cH8KHZc3mr7YebQnJtyUQjOAnrurVZ?=
 =?us-ascii?Q?7jEtqlo9ALEZhW9VKYw7XKbtyec0tCQNNexFWntxunHrAtjN/Wo/WROVihfw?=
 =?us-ascii?Q?eS26kCzi9I8xePA5Gj65Ccz8AVZ33mCnH/jpV2W5iHuFvcMwWKJ1gxIs7l3a?=
 =?us-ascii?Q?V20Kxt/QnA0u69bq0izKzKz3M5YJkT4std+ABKso6E6XheLc3J8g7gq3guG/?=
 =?us-ascii?Q?a7bdadx0Iowi//yX03TKY/1WF73+9xCUNYUhZBvXS2Smhz07xZ9GU+kOWwSY?=
 =?us-ascii?Q?78613kG8q26KdKkC960CeqF8tUwH4kKZhfFjSgOisB7EjtFZ1utFjOTFmXh3?=
 =?us-ascii?Q?PYW8JxydtCkVwoUmcTqm8p5dGVwbrgtwA+i2xgtJ5Y0VpBv1X9GOkNAPSkGn?=
 =?us-ascii?Q?vzHOVnMJpUfLsUU8PpqKhwI57SNDtZ9ohif13kj28gMVHadz4Gj7rBhJHBY3?=
 =?us-ascii?Q?tqxz/MY+KsYcjAIVNKz7z+NcCCeadiAXN8xaKf2gjiqAg8AHoBZj1PHHybTH?=
 =?us-ascii?Q?CbFoZhpr0e4jDyiwouFUaeBwZBekNHAHvjZshA70Eb0pStuBlfR73UpQ5Snf?=
 =?us-ascii?Q?SsQ29XcRvybRDQVbtnHQeHGh7cU5Md/1PzdYK3vFWTjRQ++m5lrE6S2a6tFp?=
 =?us-ascii?Q?jtMmYMIDqX0euKoBn30xxxsysuIuecDst8n6+qoR7wVUytftolmxKVvc1toB?=
 =?us-ascii?Q?XWJeCYFJFTP6rOCXgbrTpRoV8QufT7Tp0fcIkjR1SEg97gBOYz8ZJhTjqXWk?=
 =?us-ascii?Q?1WgGy1LLivCUm87g4kP5/+V8OgNtLVO6IE60l/TJgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h7RNlMd94ZERk9UVBk6qGU9UWnpOYY0zYMi1iNm1XG1aQxDToKoOjV5oQvdP?=
 =?us-ascii?Q?7JWlMRD3a66qW9xadR9EUX/P0l7rZuxJmq9CaAlO+nmhlUOr0VQxUSElHYnK?=
 =?us-ascii?Q?5zcwn6GqnUdey8gIPS6uR2qGKWIXieKKcyEfhgHNDwho273CgPWxACHor5Hz?=
 =?us-ascii?Q?5RfOHkrgq9F1umrG1Aln6rmOQWra+bZv+IClXIV6Z84LA5XB2YZ0IWNrMZsB?=
 =?us-ascii?Q?9hEL4OKFIeA/DaJnPHI5RLqTQaT2hSWUQfQ2gUgGmP5msIKI5MSmaHeoSon2?=
 =?us-ascii?Q?py7RGoCRBXLHzqeRye7p2KSECVIOkwoYKnENdlkXzwyGRlwtycEr3MqkLpCV?=
 =?us-ascii?Q?72S/IMvqtyQn9adn/AgynUjpx7f3lCbAaaf8gKqZ2RNtB5jmwzsDDe+U/Wh6?=
 =?us-ascii?Q?Bou4GGm73IegTR8zbeo83Kr+vC5J+dTnrPxtulEDDpdVabCYPMaxZsP17AwV?=
 =?us-ascii?Q?jzQzeyTXpDwcfoCDS0umkH76vwuFNPyR/APVsguveY02qvxxdS9chTRjrntl?=
 =?us-ascii?Q?BKcS8MhMkcUAkNLYypNouexud+l9JFyW6CT8O84eNEIDQ2xFWGrrk0/cN9OZ?=
 =?us-ascii?Q?f6LE0EJ0U3q0+GsUUFwkcogH3uvECA+Bhcki1/qpm/OLPAhAaX++lTGEcdEL?=
 =?us-ascii?Q?2OcxgCzDSI4+yBzoxgE+48z54O7VNLwdup0QDHcTtA7/vCvZx3Qt5Z3OFrWD?=
 =?us-ascii?Q?Cn4aJ8Ff1m+XqDPpEzWeXHf1KzMgv3c4iqmU/gjO8TrfkZd2/AOWOrMp5TOU?=
 =?us-ascii?Q?B18jM0UBNpE/IleZ47cTKR7DhuS8TPzV1+d687A/+60mfgDf0CLytnQzemXC?=
 =?us-ascii?Q?oO9kILFvQ8yYMbkFuR2beL9lNjp5AQjp0hLS5UKlZtuqsRg06VVFFju5MXET?=
 =?us-ascii?Q?P77v9mfcAYS3/aSwmId8aUSOBCN1EbspvCGUqV958HP2cThZclhO3PN0jGI+?=
 =?us-ascii?Q?WBfiZw1lDH5TojRGjS72ECsTPr4WYri9t98fhzPSDOLR27xL2PY9avby+CTY?=
 =?us-ascii?Q?ZnYUXEamQV66o9InoxgfkzLr/FddrXBHEPNvdjIUu6cdnKC626T97QCMkkt2?=
 =?us-ascii?Q?gezuMzF3VTlXfmZAZj56qjMIrf5I/5w9i6UYOgK2aC5mdOyT7LkSJWh8QMG1?=
 =?us-ascii?Q?Ym5E6qq7J7y4V1fvgC2co2yTjMSKGK5SGCd2T11N4pf2g2zk///5wgHe4dXa?=
 =?us-ascii?Q?/TDlm9UUi+cNAlPmHwZz7d1fdlrZWNdsHewtPUtGRCWKtjQFaKBmrISmka9j?=
 =?us-ascii?Q?lhqPz068ApVO3h4XHEgVMvVqUiqDmfobDMTMOupwePjRLFuPGrLCSFi6EYaW?=
 =?us-ascii?Q?lYOGy7KezJRVwmYa0HDO3rglanP6PHvtP0Qp/fSl1ROOdbEu0rUebHjdkSMH?=
 =?us-ascii?Q?2+42tNQIRgkwTda2cToWsM4L1xVyP7W279SVBrNp++HqlrgMb5DqL6y8X3JP?=
 =?us-ascii?Q?AvRUN5D1xrhn9GHhfdpQR9YUytri9xX+63BWs5dSAVrVQm7i7ITqgj4ClR2p?=
 =?us-ascii?Q?mRxz7Fkn1FBrTG/ypkngfrtUPpEanJNyMwQFOxSGAvpZpLpRnLcTI9mi5iuA?=
 =?us-ascii?Q?JbJljCsa2Jf1/35wveArbWYo/wCOFKqcwTF3r/oy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70d578c-0171-47b7-6348-08dc6171770c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 19:38:33.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ3QupKCKX0uyFzLd7Cr956wCiXLzEe4P+b5HmBwzXfZUDAwaFlB2XCD8ibUfgg2yqrCS0CV2t5CCst0R6XOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

On 2024-04-19 14:30 -0700, Rahul Rameshbabu wrote:
> Some device drivers support devices that enable them to annotate whether a
> Rx skb refers to a packet that was processed by the MACsec offloading
> functionality of the device. Logic in the Rx handling for MACsec offload
> does not utilize this information to preemptively avoid forwarding to the
> macsec netdev currently. Because of this, things like multicast messages or
> unicast messages with an unmatched destination address such as ARP requests
> are forwarded to the macsec netdev whether the message received was MACsec
> encrypted or not. The goal of this patch series is to improve the Rx
> handling for MACsec offload for devices capable of annotating skbs received
> that were decrypted by the NIC offload for MACsec.
> 
> Here is a summary of the issue that occurs with the existing logic today.
> 
>     * The current design of the MACsec offload handling path tries to use
>       "best guess" mechanisms for determining whether a packet associated
>       with the currently handled skb in the datapath was processed via HW
>       offload
>     * The best guess mechanism uses the following heuristic logic (in order of
>       precedence)
>       - Check if header destination MAC address matches MACsec netdev MAC
>         address -> forward to MACsec port
>       - Check if packet is multicast traffic -> forward to MACsec port
>       - MACsec security channel was able to be looked up from skb offload
>         context (mlx5 only) -> forward to MACsec port
>     * Problem: plaintext traffic can potentially solicit a MACsec encrypted
>       response from the offload device
>       - Core aspect of MACsec is that it identifies unauthorized LAN connections
>         and excludes them from communication
>         + This behavior can be seen when not enabling offload for MACsec
>       - The offload behavior violates this principle in MACsec
> 
> I believe this behavior is a security bug since applications utilizing
> MACsec could be exploited using this behavior, and the correct way to
> resolve this is by having the hardware correctly indicate whether MACsec
> offload occurred for the packet or not. In the patches in this series, I
> leave a warning for when the problematic path occurs because I cannot
> figure out a secure way to fix the security issue that applies to the core
> MACsec offload handling in the Rx path without breaking MACsec offload for
> other vendors.
> 
> Shown at the bottom is an example use case where plaintext traffic sent to
> a physical port of a NIC configured for MACsec offload is unable to be
> handled correctly by the software stack when the NIC provides awareness to
> the kernel about whether the received packet is MACsec traffic or not. In
> this specific example, plaintext ARP requests are being responded with
> MACsec encrypted ARP replies (which leads to routing information being
> unable to be built for the requester).
> 
>     Side 1
> 
>       ip link del macsec0
>       ip address flush mlx5_1
>       ip address add 1.1.1.1/24 dev mlx5_1
>       ip link set dev mlx5_1 up
>       ip link add link mlx5_1 macsec0 type macsec sci 1 encrypt on
>       ip link set dev macsec0 address 00:11:22:33:44:66
>       ip macsec offload macsec0 mac
>       ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
>       ip macsec add macsec0 rx sci 2 on
>       ip macsec add macsec0 rx sci 2 sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
>       ip address flush macsec0
>       ip address add 2.2.2.1/24 dev macsec0
>       ip link set dev macsec0 up
> 
>       # macsec0 enters promiscuous mode.
>       # This enables all traffic received on macsec_vlan to be processed by
>       # the macsec offload rx datapath. This however means that traffic
>       # meant to be received by mlx5_1 will be incorrectly steered to
>       # macsec0 as well.
> 
>       ip link add link macsec0 name macsec_vlan type vlan id 1
>       ip link set dev macsec_vlan address 00:11:22:33:44:88
>       ip address flush macsec_vlan
>       ip address add 3.3.3.1/24 dev macsec_vlan
>       ip link set dev macsec_vlan up
> 
>     Side 2
> 
>       ip link del macsec0
>       ip address flush mlx5_1
>       ip address add 1.1.1.2/24 dev mlx5_1
>       ip link set dev mlx5_1 up
>       ip link add link mlx5_1 macsec0 type macsec sci 2 encrypt on
>       ip link set dev macsec0 address 00:11:22:33:44:77
>       ip macsec offload macsec0 mac
>       ip macsec add macsec0 tx sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
>       ip macsec add macsec0 rx sci 1 on
>       ip macsec add macsec0 rx sci 1 sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
>       ip address flush macsec0
>       ip address add 2.2.2.2/24 dev macsec0
>       ip link set dev macsec0 up
> 
>       # macsec0 enters promiscuous mode.
>       # This enables all traffic received on macsec_vlan to be processed by
>       # the macsec offload rx datapath. This however means that traffic
>       # meant to be received by mlx5_1 will be incorrectly steered to
>       # macsec0 as well.
> 
>       ip link add link macsec0 name macsec_vlan type vlan id 1
>       ip link set dev macsec_vlan address 00:11:22:33:44:99
>       ip address flush macsec_vlan
>       ip address add 3.3.3.2/24 dev macsec_vlan
>       ip link set dev macsec_vlan up
> 
>     Side 1
> 
>       ping -I mlx5_1 1.1.1.2
>       PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
>       From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
>       ping: sendmsg: No route to host
>       From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
>       From 1.1.1.1 icmp_seq=3 Destination Host Unreachable
> 
> Changes:
> 
>   v1->v2:
>     * Fixed series subject to detail the issue being fixed
>     * Removed strange characters from cover letter
>     * Added comment in example that illustrates the impact involving
>       promiscuous mode
>     * Added patch for generalizing packet type detection
>     * Added Fixes: tags and targeting net
>     * Removed pointless warning in the heuristic Rx path for macsec offload
>     * Applied small refactor in Rx path offload to minimize scope of rx_sc
>       local variable
> 
> Link: https://github.com/Binary-Eater/macsec-rx-offload/blob/trunk/MACsec_violation_in_core_stack_offload_rx_handling.pdf
> Link: https://lore.kernel.org/netdev/20240419011740.333714-1-rrameshbabu@nvidia.com/
> Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
> Link: https://lore.kernel.org/netdev/20231116182900.46052-1-rrameshbabu@nvidia.com/
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Tested-by: Benjamin Poirier <bpoirier@nvidia.com>

