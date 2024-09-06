Return-Path: <stable+bounces-73707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0996ED86
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13466282E88
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE4156C40;
	Fri,  6 Sep 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aINaTCEV"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340D1553BC;
	Fri,  6 Sep 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610626; cv=fail; b=mSKhwcWZONF5RKAEHpLp11ISxYUvaXrUAhPUZF70p9cSnruczpemjnEiN7bBXJDt9zKxp9y4PwB72GlVUr/KWR8B/zjaKloTY04Tl9Loiww2NDD4/LchvfYqH8xauiV9u6lTugkztRA5Z0v5k+O1KKf/PNT258XsaOklowS3cMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610626; c=relaxed/simple;
	bh=qQg0ZDTzMUfLamYMP3PigzrGENUec99Y8ZomfPWNIWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G37kMd7CjDt9SqbvHNlzNASrEg3ePEew08jmd5rKFVxbDXvc1nDWFw49bhRuU/0FcILbO+zXpp1OzdJMzTV0SYRTc72oq2Ug1E3FhOhscnmQa8vhSI/9yncbaPen+l8qoPcWLZTMCB7d+cyH78a6wWGhGoycQZrvThFL7zZUek0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aINaTCEV; arc=fail smtp.client-ip=40.107.117.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmXKX0LQfm5rU9jZUij8qJLAExxub8Rm9Q9ZreeQZvcxoQ2V6p0gJYGaCtjLcDFWP+PBB+53YelqFclSX8n4zwU+oqGZU9jVZreXvBQYEWpCXm2ACGFueQy+mB/o4CZAPWsdVd3kjQHxvmeqSjmjw4gwsH7sGcJfVQjLb22LrwRaSLhI2QoRFLFyK8v3Fuggq8+p5PEs+tD4muR27FQY8NIQj866O4g53DaVOGc/AZ9FvyejH5qbb+z0lO2cyqSplim/g92qt13BIFpSR6dG9Ll4xDXXf7Qoqy8lJH4F2czs2gt8B0nh48wo0C7n8BRonrhxxlc3obfnThiYyktVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMEAYdKfFXO07i1fH7UCBEpLMj5qF2YH3KGZFVaJ284=;
 b=hlSNsBSVSHxu4TJ1kAOiXTeFED+KkqnzwS/NgFd3XQHDJ4MJxiq6yuThzkp5CoPNe0UQncfgxGyST3hX54pdI+7uY9hafytSWbRyikh8zuHplS+SSJJqIf1f2s+4HhdM2QsDO+57A3SkrSH9KsbeIkn8B7kMN+Z3zSycYKDRg4r8n7uobZQP9dYrCNYBERgJA4vGVbZXkppRu1yUTsAUYlHtep8LYQoxly6JKrynJBW4BRJ26pCOdXx8nlZFLKUir39NaqbvMtFhppvgL5ijTohISKDL2senVDr41f5nXe/vbBwyDoXCHi4Y5J5KBukSPvHUOMbzDwCs0AMRkZvTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMEAYdKfFXO07i1fH7UCBEpLMj5qF2YH3KGZFVaJ284=;
 b=aINaTCEVV/YLd/uJdCB5ikTa2MJIBUiPV6Y5CZYtZH4u1oS4L419Mbzsx0GFEbiW7M5ZTE7DCt8swcC5tQsSVFHlyCfdcNqKp7uzXBOB0UY/TO0j9LWC/RYKiJ+HaewY6jLLQ8lC8otGgY/gn2kEXT/Yr4fFXvbjj7i4MNGP12tmxSp6BFa7L3UiO4fjU45svd0maNJKpIzfo6xF9aCqDA5ydAyoRxBUp50Sqr+2kdSASkB8p07CFH0I491K8v4e/cBNSgUDDtVmrQcsx8JodcHP+PWSi/tjrA+hgob4Y9u3Gm1PSIKjfttMj6QjlThhx67tURO1dv+c60X6ZfQo4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4494.apcprd06.prod.outlook.com (2603:1096:400:88::10)
 by PUZPR06MB6066.apcprd06.prod.outlook.com (2603:1096:301:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 08:16:58 +0000
Received: from TYZPR06MB4494.apcprd06.prod.outlook.com
 ([fe80::a5cd:b456:d951:32c4]) by TYZPR06MB4494.apcprd06.prod.outlook.com
 ([fe80::a5cd:b456:d951:32c4%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:16:57 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wu Bo <bo.wu@vivo.com>,
	Wu Bo <wubo.oduw@gmail.com>,
	Chao Yu <chao@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN happens"
Date: Fri,  6 Sep 2024 02:31:17 -0600
Message-Id: <20240906083117.3648386-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f51946e2-68f4-4368-9a77-050382dfa3ff@kernel.org>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To TYZPR06MB4494.apcprd06.prod.outlook.com
 (2603:1096:400:88::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4494:EE_|PUZPR06MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: e44b46f1-2399-4c72-df31-08dcce4c4654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJKTWxNSDU0cis2RGR0bHpTRndueHZ4d3NRNXU2bDYyV3FQZ0tkVE93ZGR4?=
 =?utf-8?B?Zm1aWFdGa3QrSE1ONzdYM3l1UXQ1cTg3aVJ5d0lpYlgwVGF2Mkt2MlU1OHJC?=
 =?utf-8?B?cTJob1B3b2QwaTk5OTFEK29XWFhUZklaQUdyYUlCdkRPRUNndXJtTS9teFN2?=
 =?utf-8?B?N0c2azhPVjNQUE5BVnd0MkhpM0NuK1B4WlJXVHdHcXQrTUNHU214dVpSNTE3?=
 =?utf-8?B?UmhUQTRpSjNsbFdKRHczYTBnRlQrcFRPekRWdDdETFZWWWRYaDRJNlJRZnhk?=
 =?utf-8?B?WW5sRTV4MXlwemF0NE85SmpaRU0xZGNjQnJYT1hjSmt5Z3RxaDcxYUpBZFhM?=
 =?utf-8?B?bUxQbUVKbTU5WjVPcy9kUWw5V2ViWkYvOHVKRVVLMzk0dzErZVlmTHBkUmdt?=
 =?utf-8?B?aWJnajhGd0xpcXNkV0JEdE56a3pGTmxtVmNhVTlFQkpEVzV3ejFMRzBxekNM?=
 =?utf-8?B?bHZINmVES3Rad3hkanNTYjRLMWFGNEtlcms0WmNGMnFYUVN0S1l0TTRCU2FK?=
 =?utf-8?B?TVd0NXc1RU5nczdMdlhZSEY2SHhpUU1FTHBJMGdBUjNtbnR0ZGYwSXh4K3dx?=
 =?utf-8?B?aFpnVjRRUzhCeVFHZ0dNM1BqSmtSbCtyTS9VaGFhYjhPSUd5NmMxQkhLOXJz?=
 =?utf-8?B?YXpGS1VOZEhIUFViekdBQ3VrS1BOdmwzYm81RGI0YlAvSWZqdDhxUTVPWlNQ?=
 =?utf-8?B?U1dScnU3Nm9iQVVaSy9LaFVlaFdkRUR4N0duWTRaNUFBR1MzU29xUDhUaGwz?=
 =?utf-8?B?bHl5RFE2UERqd2Q0QVd5eFdOa05xQTc0UUxzd3hyUUNSTTEzN2JrTGNmTkwy?=
 =?utf-8?B?eEFhc25zZG9aWldwQ1RYOS85bTE2T3BKWTlSRmJqNCtVclpZL1A1K1puamFk?=
 =?utf-8?B?Z1NYZVhhMWd0dG5ydmFaUU8vU1BFelV3N08wZVBtQ001SzJpeUZXR2tjTEli?=
 =?utf-8?B?NG92UVhEajN3YTkrMU9aNnExVE9ubU1yZUdkREVOeHVzU1RsZTRGUHFjRVor?=
 =?utf-8?B?dFBWeVhLZTVRemFtV0pwcGUwTVE0bmF3Zy9OMGgzUTdQaXpIYjZPNlRBaGtq?=
 =?utf-8?B?NWpZWjZaK2JnclZoa2NYQi82WE1FZ085YjlOMGZGS0NHSEdIOVpkQWE2WW9Q?=
 =?utf-8?B?empBeGpMK1BPMC9hZm1QNUh1UzlDbnZydStmQy85SGJXRm1lV1JLK0xoUlFa?=
 =?utf-8?B?ZmtKRkpZTlZSTjZ4b2lUVWpJVTFGRmpzYmVHVXNLQ1Y1bHJRdnpNWjl1U1BB?=
 =?utf-8?B?bU5aNGhMZW1kNUhtSm1zb2o1aXdnZEM5aDk2YTZUdXIrbkUzemlKUjBFWTAy?=
 =?utf-8?B?U0pQcWNzeldYeUFLVlI0dHN3NExIYzRnblRuUDR5R2xDUmtubmFjUy9GUE1J?=
 =?utf-8?B?YXNjcmVzU0F1c1pCc01QTjhaLzNFVVhYcysvR0c3VVc3K1NXamZPaVRJNzRo?=
 =?utf-8?B?UzVFR3JCMXVlejQwMkZGS293bjZacnA4OW9ubGpXeWdETlArOG5BaWE2b1Ru?=
 =?utf-8?B?V2wzZGdjeERHcjNNNWhJM3dENXVNaVdIU3VXbi9SdlQwOG1wQjdpODJPZjND?=
 =?utf-8?B?aXdPME9ISW9uNFdjazh6NWhFM2ZaWkJ0dnFxYXBqa2x4NDBWcklPdSsyMUc3?=
 =?utf-8?B?TmdJY3NHVW5sQ1NneEhKNWdsN2xqc0x2V3BCNGxJeVpWSWdKcEZJUEpaN2Ex?=
 =?utf-8?B?YVh4Qm44TnY2TnNRQXBmdUpUWUtZb3F4Y2Uwa1ErWFFMclo4WHUzSUZ4a2Y2?=
 =?utf-8?B?RVFLVjRCR0lrVE9ndjRYOTZzSjcrSlNmWTNrMTY0TXo0cEVlQVQyK3hIbXN1?=
 =?utf-8?B?enB5WThqOFJjeXJsNEFVNzJYUitGTWQvNDJocHVHOUFWNlppc2pvQlJDMXhC?=
 =?utf-8?B?ZEZUaTViUHRUa3EzT3IvT0Y1Q3VqUUJVKytwd3JQMFp1RWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4494.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWt3UzZTRnprcjcvT1VlLzVGclpLM3dUZ2VHZ0hDVGh4NFM5dld6bXlyMW1I?=
 =?utf-8?B?VmlhWDVQYnJZSm5ocWpMWmFxbmFncDZPTk1nM2NmV2pWZnhSWFFHMnRvVG5r?=
 =?utf-8?B?cTNrUjdBMHM0MkNvOXJBNHRlbUFrRzBQaGZVaXhUeWpqZGttV1YrTVZPMHhk?=
 =?utf-8?B?SWxpdTNOQjZIREY3eWhhKzZ6enVJWFF4WmdzaldubkRTQzRSQXVYYkhUZHRK?=
 =?utf-8?B?Qmx2TzJxK0VzVm53aU9VajAwbUNpUFd1ajJPWWtZR2IzZ0hLV0Z5TDdMK0Ez?=
 =?utf-8?B?UUFSLzZ1RWd1QW8rUmZPejAxTC9UV3VjQ0I1SlRsWGwrdjhMQ2JVbVN2T1RR?=
 =?utf-8?B?UkNRNm5DMWtUVHUvL1FySm82UFFaeHlUMmk5Z2RHVVpjVGl5TVEyb0NWanpS?=
 =?utf-8?B?bDc3TmZmRDNqb05tSG9iUnBkYUt0M2lSWEkzMThGelc2djJOVUx5MWdYWTFu?=
 =?utf-8?B?Tk1jZmExZmhDd3F6VkxwRnpsWDh5MlBmM081czZBc05UWkhsbEJjUlorYklk?=
 =?utf-8?B?Z29hMDdyeW1oMUVGUGZhai80OEhyRXhkeVRzUE02NUlRbWlUdTBzMDUvaUZw?=
 =?utf-8?B?RWs1cWpaZFZoMXdEMERZRmJzWS84T09LNGwrQlpVRWV3Tm1pTHNNN3Zmc2Rl?=
 =?utf-8?B?S29BSzFnOFExVEJTRWU0WDlWMlg4TStlMG5zWDFLUDlvNmozUEZUUWxVa2RE?=
 =?utf-8?B?RkJPcll2cUpiYnFUVUFGcXBCbHc4VU1DY2d3TFFlMFFaZ3czblFZTGVZYTZV?=
 =?utf-8?B?ekhQNHR6YzBQaHMzMEJoTWtnaDlZY1ZxNmo5UWJRWXp6dml6OXB0amxINFla?=
 =?utf-8?B?c3NoeVcvZ0RSVGhSLzVjdHNNd2ZXMkdSa3oyTFBMaVhqVUtUa1oyM1JpU0RN?=
 =?utf-8?B?TnJBRHF5dkorVyt4azZlcU1scGE5TjdRK0l4Y3dabmMvZDNneU5pR05LSWU4?=
 =?utf-8?B?LzQ4VFdiOS9DZEU3dWxBQkF4Ukp4QlFLRVpCMVNiVldGMUNua2U5V0hjQkN4?=
 =?utf-8?B?eW1FZGkzaU1VbTNQaEYrQkVEbVBCdkhaWFA5cmpSRUdYbUkrRTQrYkZPclBZ?=
 =?utf-8?B?cTJITGdjbTNNeFhGNUlzejFDdS9DTERJMllKYm05YTMwS0pqYUVYMHhSY0Qx?=
 =?utf-8?B?bmtjQ1FpRE9WUmdlaUpLeHA0T05RYlRYeEd3MUpHR1ZGQ01lT3JTSmwxWUhh?=
 =?utf-8?B?ODRVKzlqRmo1QzNpbG9SQVRMdFduMk1JUnlBeVFYNkhvNGNaYlV6VG16YjdV?=
 =?utf-8?B?Ykw5Q3ZpVnZ3azlJRjdYMmpLUWtJN0lJcTNKNkd1WWFVcWIzZGxXUStxK1FM?=
 =?utf-8?B?YUgrK01xMDlPamVkWlpUT0lONGMvNE5BRnBUMlZhYjYxcy9hRWE1ci8rNXY1?=
 =?utf-8?B?aksyd2wvKzBHdmQrV2ZrdkozWlNwVnZhYTA2Kzd4TDR0aG96ZVZSZXVML0Mv?=
 =?utf-8?B?QXN5OE1xMHBYb1U4bG9jaTE0ejRwTHZaeEtxb3FLUEptYUNENExKL05DUFNo?=
 =?utf-8?B?aFEvc09WdlNkQW4wUE1pQnhOQ3k2a3JVWHdDUjhIZElnT2V4RmptZzJCTGta?=
 =?utf-8?B?bnozN2dqN1BRMWJsR21HZHFCY1VmU2tVbXhTeWwwU3hJWHJtQXZsYVZRMWor?=
 =?utf-8?B?TElGQW5XLzVzR01IVWFJUFc1ekVzYzJxcXJTdjdPR3cvZUtBZTcyci9KWVFn?=
 =?utf-8?B?YmlHMU5aa2h6U3BlQ08yZUpjVTNDbjJsOUQxMDRsaXZxVzlGR1VIS2E2L2R1?=
 =?utf-8?B?cHdHM01MYWU3aHFWbnhPanllVUJVYXdtOVJ6NVNtZzkrT1RQcUVUOWZWcXRV?=
 =?utf-8?B?UVVEVENOUHAyM3dYSzQ5VjFQL0RKSVF3cE5SOUR3dWU2elNhczRDQ3MxaWx6?=
 =?utf-8?B?TmZucnUwYUpHSHNDNDRYMEw0bURZZ2pKdWU2SEtORVVPcHdEdXJNL1JHMlhP?=
 =?utf-8?B?QmRFTWVBOXBsY2dXUnVmQ1lVWXdQUW1lZnd4YkRWeVhNb3VwQ1BBNHdrbGtK?=
 =?utf-8?B?N2NZby92OWZoZGVmQWgzU2Y4ZWpqYWxlNUhBaU41cUlYdFR5QUIxY2FQZGFR?=
 =?utf-8?B?YjVYZ3ptblhLMTZuY1h0YUxPVWd1QjIwQmkxVGYrN2hZTjZFU2d4KzZFSG82?=
 =?utf-8?Q?c9fIunHONg3AuWG4zQWBt5Kml?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44b46f1-2399-4c72-df31-08dcce4c4654
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4494.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:16:57.5688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLwaYK9HHXart4D+OorROfAywr16raflAWvfRH8aApNmn/bt343uiR2McU1te0+UNiDs9PuDVreYVPOrn2AtPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6066

On Tue, Feb 20, 2024 at 02:50:11PM +0800, Chao Yu wrote:
> On 2024/2/8 16:11, Wu Bo wrote:
> > On 2024/2/5 11:54, Chao Yu wrote:
> > > How about calling f2fs_balance_fs() to double check and make sure there is
> > > enough free space for following allocation.
> > > 
> > >         if (has_not_enough_free_secs(sbi, 0,
> > >             GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
> > >             f2fs_down_write(&sbi->gc_lock);
> > >             stat_inc_gc_call_count(sbi, FOREGROUND);
> > >             err = f2fs_gc(sbi, &gc_control);
> > >             if (err == -EAGAIN)
> > >                 f2fs_balance_fs(sbi, true);
> > >             if (err && err != -ENODATA)
> > >                 goto out_err;
> > >         }
> > > 
> > > Thanks,
> > 
> > f2fs_balance_fs() here will not change procedure branch and may just trigger another GC.
> > 
> > I'm afraid this is a bit redundant.
> 
> Okay.
> 
> I guess maybe Jaegeuk has concern which is the reason to commit
> 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN happens").

Hi Jaegeuk,

We occasionally receive user complaints about OTA failures caused by this issue.
Please consider merging this patch.

Thanks

> 
> Thanks,
> 
> > 
> > > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

