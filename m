Return-Path: <stable+bounces-243955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHIsLxZo+Wmt8QIAu9opvQ
	(envelope-from <stable+bounces-243955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:46:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F86D4C644D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0532301DCFD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 03:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292C3AA4F9;
	Tue,  5 May 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YbJEY5HX"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AD35A927;
	Tue,  5 May 2026 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777952785; cv=fail; b=qXxZ3Ub7Vl+JVYH+GQnUwcLWrZR82eifUP9+JUSVlN1+xPtEVTi4KIPynd24gNpx+isYEydOMDViYDHImJ0WeA7dxyaHXekjV7yBFMQdeYoxJvqgp78gRKPp7S/9TJY0ASgBw6I8t8n4jmoZ77NUZTiJL8AuetkV4e4nTAcymNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777952785; c=relaxed/simple;
	bh=tPx2rMA8Ee8+EnM7nyz7CNCoOg+24MXRKb/O5vHP5uA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oKLQ0FMiKTKOef5kvcA1jFoMaXE9bcA9i4KRQGI8vSOK2Um08yN1SWVdfTp61GANnbhZ/oRgOmTl5E2SXtibJWo1nV1gtSUerxclw8HAI+IZeqAt77KkneIr3RZF4x0xkbYAI9NeUFh9mpognjwa5rYxMKlEtDqVMqEZkTnZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbJEY5HX; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8mDYn9EjlgFMLrNPR+PErtUOy7DsmYAD2mHoZeJ+YqsFZbxOQyK7YRa8dhIgxjXEafBwykdc7r7g8I3Rwb8M/E1X4LZCCOt5mxVGQicc2cHX2QxUofC9U6DjgIamKb6UEqoDzwMsixU3lIrOfa0wb8M/Q4qizwwKxTV7HZoIY3EEQTkm47QF8VbT9XHcQ/h0hkslPYylRatYp7NSH8+MgLNpMjvOLE2B1pyiHL08FeKaOp5bgR8DKA5PdXM4HH7REmjK2e3s9w/dP/JDpP06krF9hBvQcN4M6U1kK0H/RZHLInaAvPTo8D+Ha2SND8KGciyfrjsAqvUZVrFUgB4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z2W+bv6xizSKgE3AnpNHd9GLn2c6KqOnvH4HyWunFA=;
 b=XmYq1L9IuAFxgQSgD47SxVC4qduS4209kXY6aauv6JcnoR3wvMVFlc0SuBafanDpPgwG8Nb1lwQ8i7M8Pr7p0KZegk/Iy75gm/vOu8e31zSnxcfAQnqVx5ug2JEviAUqFfmV/lTrxQmFGb8eQgSHXU6HXRpW0IBEbElsfRm2GmeIb/fSp1qJOI+zD8M1uFNUx51qb2aS86EfYkIOgeUpK/Q6pz2qgc7PP9gFN51H83CbEowcwitTixaLte7xdG/1C5MH9F48+rs9ilsv9Jo1p9RYgb2i+OXd8tCAhBsou2B3M92R0H4aYxSyPV+N4TLugH0w0d9nVRpv0SZD+JyYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z2W+bv6xizSKgE3AnpNHd9GLn2c6KqOnvH4HyWunFA=;
 b=YbJEY5HXLvhxbfMIWgz/iZbVV0BGUmlJn455luCQGBS1Ry4Cm+zTlpu/Xd9ayr5UbZ2UKYvjfFT9ha8UUfAsexoXZIdO1yy66+BdkwUhfivoPo8oWUg7P6WFFX8dcDHWADaXlk/MEhXA6uKDE5pqnwIroT+6xDo2NbwPTE9gtd8SZFviD7fbQuFaQsY/5t1nshHQEmgeHX2RWL/z4QLxq68iXXod8E096eOUvbEN3f0B4tBSmq/IejG/Vh0Rjz7DYNp06ihlCmnbQIlkdpA5uO2X6F2fZTrlaeETWEj/Bd+NsZB7X0SRcgNQkizJ/fxR6m7FYY3zNOc94+SuCxt1ww==
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 03:46:17 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::e2) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Tue,
 5 May 2026 03:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 03:46:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 20:46:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 20:46:01 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 20:45:53 -0700
Date: Mon, 4 May 2026 20:45:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Kai Aizen <kai.aizen.dev@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <afln6NzEyTHpcKQj@nvidia.com>
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: e4334fcd-fd04-433f-f5de-08deaa58dcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	odxMfIu22Wwqcnckl/VNMkx4zC76bk8RaAEgM0jY8b66BvQqt81TxLv9eJkM5LdSKAP2iaF5rw6zJrPoPY28UYxB2q2bYBEtXtJDfHuK3/CUf1jUAZJOqbEOy55s8AgGQNniP4YFWvHyrhe2/FwKKkYEMbjWrDtOrE7YDe6VyJCUkIfC/5ZvwWY3rZWzu/ygO6yZOmQzhkhLcWByLkf7T6jw51kGJmb3KGTkyjPm8pZcaOF73oKJg1vk5iyIVM6F31XSA6j/I3ZA4xbuGeNR6piYoMuXAyabNY9cw/nZ0dov6BxHaKFt1tYFyqahDafmoneeIAEQXQShKNkPYdPtumRpxVlLCz9vLOOs8jeo06FEmI/Ku2vAdbekiDwfi0BdqhkG7lxSfFRwUx+kedbjss9IBlRJMmG5smjbwV+n2WqKCEpZsOZb6cEnDF31vvBDcNfSUg/x2UMJdcgnIkZ5Kd83ebNXp6bri16Nee4SU+waCaJpX3lYORHGEH/5Iapbx1KCfKeT+W+QVVzQi043ML0y7qT0UrkMjHVDrcJQy8wJB8eDh40HU/GTv/ayjTQ98R4zqgBsmP40FODPhEZVC+RG2sK8X/X+ZCYSNbgz23guUrxHKBzDI3GZ7BhIKpPkdjBwEv6ME9J5iA8O8TTyeGI6PZmf1Wlbb3hRV50VOxSrCJJL60ZL/tUVot25ilUQhYum4rrgUp2lFOeH6FptbojwMTQCfAuFd44yf9f4Wto=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LVCZ2WcRYwEpkJJ5v9IVUD19WOLWwv1KDvLOo51XioDJWynoW1xAFTL7hAkZ24R9xcyOQTaA7hcKYtKsGyYWawWtu6eSP3BZgP71JSn0fmAAB/OBAGA7RGEk7lO5IwpfVoTBNLJddWmMq3XSEyvWwBY98LWvuZaw/bwc+spCL/HhgvbNgtCuaWUZhTCw32pMrYGhBvGYrJODWB9AiEDhU0HHP0+KKza64EhGXMijoGPEvQbY74ChzQZtosr8bGzr7TWRJJJYweIUhTfqoaAN0Dy4J44BaQ3l1xZxinN/h2P/4iMQ+evPKmLD9B1y/ie50RdzT5FjdrzRMG+VgL+Wy33ZHf2qRv0uy7z/zf472RDMLS5xGd9hTDM+xl/NjYaXWeKghTE3Mw6zrnAQGxT3VP44LI+F/dTiVVjCZhDSwZr5uCPQcwqbuFnxk+MoJFJz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 03:46:17.2147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4334fcd-fd04-433f-f5de-08deaa58dcdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
X-Rspamd-Queue-Id: 1F86D4C644D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243955-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

On Thu, Apr 30, 2026 at 08:56:30PM +0300, Kai Aizen wrote:
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
> 
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
> 
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
> 
> 	if (done >= count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done += sizeof(*hdr);
> 
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
> expressions happen to be equal and the check works as intended.
> 
> On 32-bit (sizeof(void *) == 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
> 
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
> 
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

