Return-Path: <stable+bounces-38012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3A89FFA1
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DA62837C9
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E51802B8;
	Wed, 10 Apr 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i014f0+i"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5717BB07;
	Wed, 10 Apr 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773015; cv=fail; b=f+eDwfeCW480yabC1/1Px3wiekKAARcm8sF1g+t1Y9Ez4OF2iaUXvfW/NCYYYC3OiqtBtbkhW4mmpnAA8yN8p8qjrf7FOh3rhJyhKjAuvL0amMNYGZbEXe0hN+QIlObkaSp6GUBEs3vFi0cmhX7MW2CU+PXADI9P4K4G3n4q7qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773015; c=relaxed/simple;
	bh=owCAfYYR7YZPOKPdLh9mi/MbQQwOXP3H4PVOzv6oMDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuxiUQ0q0d31JCdTbdKPSmcjoePGZ+EL7lr+AUhqjMLAtKcQm+SC91eyVIQAcj5W4D1lzrBibFIG1hXNrBWjPLFbpRkYzGSijRG9ultyIP6DSWuXFPfSj2IAxprk3VLYqiY0jScqCTD2IycYRoktxxgNz4UWB7l/G/vCS1gpPS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=i014f0+i; arc=fail smtp.client-ip=40.107.117.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY5FuFqBCHm8i5kv2KGuvQonhPityeuPSW0JvoVQmVsODkqz+r4+fQoyxS4AcgXeg+/gbD7IcsgdX23ay8h+gGa9MWA6fMr5Qty3m1z6cw4CTcQEKLQvLn6ILbZlXMJjZe9DqJKuT6LyyCoo4StkxuXTbxn6jjYiWKFGgnVXoJmpAlPrLZF1XiHroGUyLi3sUblTlAiDWs2Q8ehlK+BrdRvBSsHyO6sZdg8jF8vdyq9pv/13CRhQj2V8ihhNnUlAvF1olpPlR2hyVRPql6RXCmHBsWH4UmduGavNxubfaYj6L2ZUXA0zwaS2Jiujk8y6MLW+2KTzo6tl+s9BefA+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpO4b6HQETzitl1rfha4/QKhSKUCgSrWSC+HzcqtWXc=;
 b=CHjZjAKe+9G3AcO+mi7mVjb0o3m9gJix9NroUIaeq+MtOBdMERHq6dsbcZ/d+3OY0eI64ZA8Qj8NYqac0ysk93GPNxETIt7JZtCqgv/PL3APWPKMrLwFewsB3/xWcJCLXd+jiDcW49cwuxSru4PPEmtbu4ZJ+RrloGtambusEHjeAuJaguF4ZwtDI5HWLfcMTOt3VwHDeohYssF0JR/WeJPY6lWycYNJHDGcM8cvwgF7bUd+paqWgSjWQvcODghsdkTVnqZXeMRAfwkyDINhXV/95D34ag3Yd2VkS9tmLjZjJwmaINnoUQR7pGROc9ESPYyqclBPPMLL6A4waHWZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpO4b6HQETzitl1rfha4/QKhSKUCgSrWSC+HzcqtWXc=;
 b=i014f0+iZqYyHQt0RZr10PHsmu6z8/S8rCPvNegcZ8V1FYNQjnX9SKh+14jf/BXs10MDi7Esf0x5ZxNB2W6pSaioaYMFtuVBvA84H5j6be18PBhx6brM0bWNGKr4TVZv0rhzgjiTUZ0P5FUCnbjDT6iAFfWSEBA3yS2DtS5Z1bA=
Received: from KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM (2603:1096:820:56::9)
 by TY0P153MB0781.APCP153.PROD.OUTLOOK.COM (2603:1096:400:267::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Wed, 10 Apr
 2024 18:16:48 +0000
Received: from KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM
 ([fe80::2e18:3c6f:4926:4162]) by KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM
 ([fe80::2e18:3c6f:4926:4162%3]) with mapi id 15.20.7495.004; Wed, 10 Apr 2024
 18:16:48 +0000
From: Meetakshi Setiya <msetiya@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Steve French <sfrench@samba.org>, "Paulo Alcantara (SUSE)"
	<pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad
	<Shyam.Prasad@microsoft.com>, tom <tom@talpey.com>, Bharath S M
	<bharathsm@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>
Subject: RE: [EXTERNAL] Patch "smb: client: reuse file lease key in compound
 operations" has been added to the 6.8-stable tree
Thread-Topic: [EXTERNAL] Patch "smb: client: reuse file lease key in compound
 operations" has been added to the 6.8-stable tree
Thread-Index: AQHai2BbZCNztpGdHUi0B8XtkuZAsrFhzsNg
Date: Wed, 10 Apr 2024 18:16:46 +0000
Message-ID:
 <KL1P15301MB04507A5E901F3F462B728573BF062@KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM>
References: <20240410160122.1733623-1-sashal@kernel.org>
In-Reply-To: <20240410160122.1733623-1-sashal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dfe06301-193f-400e-b054-b4aa432634a1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-10T18:13:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1P15301MB0450:EE_|TY0P153MB0781:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5WCNYS9awOUctlFDsoDUg18CTQv7oYprZgL75BcyiCuKCxRDC2DpUPWUjcMZ/AgM3j9bBsslRmechSybY3djzC+3hM1Q9zQvg2NkVmAACyVSXBX1wiA8bzfCxgegMVmtCH040sJASAXgh03h8xD4SvD5anYIBJXOuKkLSrKTMQ0NcztGAgZZg4VzWXfIff/qzKY8qgo726Mx8rt/i5PpTkOcnkWuYD450tK2JX4QUYnkYytTiHCKN4I03P+JIo8gAwjXwOU9QsjNT//X6INqJBvpQRoKWd6JUQwhfoFgq5qKgnjaZfjxbwRDez7cGj6oXdBGSyo8LUMfKvyWYvwngEoMHQfP3bmOBp/gkWJvoGA/YGf0VrV0fb4QUje7Wc9W2K5EiwjLge45hJYRMF/egDk+e3aXhDl/uJVZnwfDxW0hPgY74lLXhUgSHjL3EP7QjG21QBFLliP4+dMWSmz5CMRbG36AiOiwokHv/qEUQRpKxYqENu6YgS2U17G+vjsqYgG5T35EoFZVatOIbhTGTdLpVW+mHHpaNhvBfq0SN9ghh05GP0qcS1pGqEA/77tnHNkQGDgO+1mLo5Zuocd+h/xGKzW3XAneUfa/QRaMAu4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E+unRxB7J8yYE3DgqDEmJvx6H0RVA8jnloSzI+YPr1+7NtTnojqEnJbqTRbo?=
 =?us-ascii?Q?bRyk/D5oUGaGVzMI2tAwPz+Omt6gFZuSrtgKEdXXaTf9ZXwMt1R2ZjHGmStb?=
 =?us-ascii?Q?Dc6VYKcrLd3zoZDbkowpOT1qKbNziZCoyzH77vxPppUIRWsXnzxHifRhMc/i?=
 =?us-ascii?Q?oIDwZmgX1n0sKR1IRwQHtR/1Zvk9E+ffrNENlegtDZpk0HLWMOk+s4K2P13o?=
 =?us-ascii?Q?e3WQO2V19EdKDT26GglAc4eZiO7Ow45lWzktAF7tU1F83quFalPoqaA7sHFe?=
 =?us-ascii?Q?2oNloiKB/orNz1U1pHj78XBQuuvUBymDznQVNaehq8poO2CZFAb+NMlVSMm4?=
 =?us-ascii?Q?EL66WyBHgbYpy/jnRUb2TIfjfeUYEda8BVwohlbMDzFJe+DRz9EXPhVVaR+5?=
 =?us-ascii?Q?WQQs/E9/Hf/OiHnBmWjIg/CJ2bIwpHMu1KvOmKBZZEK4jQ/m3Czj5nrxH51r?=
 =?us-ascii?Q?j1sm3/eVHWFuzZrpV8DVXj8jEsN9SFTI0k7Jfvv58m/aFlzOxbxsFHmcEm9+?=
 =?us-ascii?Q?Kqc9PW6wE18DK2r+6HWcxuDn08BEATx98VmTElvC6P9DKWCZqmD6XVrZ6yby?=
 =?us-ascii?Q?/4Wr4YqO5qD+VfZddSDc77gCgimTksjbQt/ZWRlErZ/v+gwqQ8jYhpI0hxud?=
 =?us-ascii?Q?HSHdCgLJXMaG9xKjF0zGJ6pg+qQR/6e9wyIdN+s82VmHrinTSDwh4N66FvHA?=
 =?us-ascii?Q?s4sh3P/ZpjHcyAbnsaiF1Qk+heZZZzLbrpTCj5FoH6O/mubZeejosBRdByIl?=
 =?us-ascii?Q?R4KoB2sU4zKsZl4yiMpogkzkcywpmL3DWmcxpkNZrMgG0XDPnYijlqtudyM2?=
 =?us-ascii?Q?2vKL2NBFAIVHX2vyoerqEUgmDeSfqn3yDs5V4WAmYtTtzGMroTlIeH/LAHGo?=
 =?us-ascii?Q?bNMJpFuw9qeNkpcNUoUMZCNU60yfdh5hT/JAAaA60iKtqcHI+ftNd7b3HLqd?=
 =?us-ascii?Q?rY1fVSC35raK88HGnKy+M/oLk2TyWRdOULGS0iV5DdOc3BU5SsnfcMF8Iyrn?=
 =?us-ascii?Q?uMAWYUJ7MHywcr8X4DeXkzVeZzTFY9qqvY/xZeYKdmSZt+vNs8Pjim7Z7x3o?=
 =?us-ascii?Q?8tS4VVl+f8hfYKTJhnCxXA1gPb8KxukY6UEhBBjM4qIA5+DjDkCIYwPGivlg?=
 =?us-ascii?Q?tIOS+biy82u/AFiJeGkeS43URRc8E4WiJrShZIpW4b1cNW8uR/AyP8EcHWRN?=
 =?us-ascii?Q?RzD+aILSvYGhTjYExnur0huGFNkwNuYRDCtN3KF3fZyFZrnYXJ71YDLgp2Gi?=
 =?us-ascii?Q?2eUC6Sj/zBZYvaVE+RqpKURfVa0EXxWiVuULpi0Z0d3VPUxex/qmGUrhFC9F?=
 =?us-ascii?Q?efPNXUrocnhBp8S6jxpxclW30GFUU8nYEDKVCclfsjqKjBP3hlGBqLGbT3pF?=
 =?us-ascii?Q?cUB2qYwQMYh7DV2qUVsKtJJ1vSTPo0OR99K9KlCe5Vfo5JMM1VDaaBXRZ2g/?=
 =?us-ascii?Q?eY6qN+RhvRVyMhNLv1w3PdCA8qNpa7MqFUwMmWKasnVLQ/+Ak4nHRHmErhDu?=
 =?us-ascii?Q?X8DPoZmg2PUbq53nU/+hqVu69Fa3wJAzumsR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1P15301MB0450.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f150e5dd-520c-409b-df7d-08dc598a624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 18:16:46.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi01JJWkH4QQTCZPuceW8BqLnP7EMQ7RJQMEat+i/Bf0VBeUgbnUaW/NqRmpKM6h+BW86ewhc7Cmp6RbXZnXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0P153MB0781

Hi

This patch is a part of a patch series and I do not think it should be appl=
ied
without the other patches since this patch when applied individually
introduces some regressions. It would be good if we could hold off adding
it for a few days as there is one more fix for this series that needs to go
to mainline.

Thanks
Meetakshi


-----Original Message-----
From: Sasha Levin <sashal@kernel.org>
Sent: Wednesday, April 10, 2024 9:31 PM
To: stable-commits@vger.kernel.org; Meetakshi Setiya <msetiya@microsoft.com=
>
Cc: Steve French <sfrench@samba.org>; Paulo Alcantara (SUSE) <pc@manguebit.=
com>; Ronnie Sahlberg <ronniesahlberg@gmail.com>; Shyam Prasad <Shyam.Prasa=
d@microsoft.com>; tom <tom@talpey.com>; Bharath S M <bharathsm@microsoft.co=
m>
Subject: [EXTERNAL] Patch "smb: client: reuse file lease key in compound op=
erations" has been added to the 6.8-stable tree

This is a note to let you know that I've just added the patch titled

    smb: client: reuse file lease key in compound operations

to the 6.8-stable tree which can be found at:
    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;a=3Dsummary

The filename of the patch is:
     smb-client-reuse-file-lease-key-in-compound-operatio.patch
and it can be found in the queue-6.8 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree, pl=
ease let <stable@vger.kernel.org> know about it.



commit 023302dc27b26e743a30097b0bbbe7b139ac1b50
Author: Meetakshi Setiya <msetiya@microsoft.com>
Date:   Tue Mar 5 22:43:51 2024 -0500

    smb: client: reuse file lease key in compound operations

    [ Upstream commit 2c7d399e551ccfd87bcae4ef5573097f3313d779 ]

    Currently, when a rename, unlink or set path size compound operation
    is requested on a file that has a lot of dirty pages to be written
    to the server, we do not send the lease key for these requests. As a
    result, the server can assume that this request is from a new client, a=
nd
    send a lease break notification to the same client, on the same
    connection. As a response to the lease break, the client can consume
    several credits to write the dirty pages to the server. Depending on th=
e
    server's credit grant implementation, the server can stop granting more
    credits to this connection, and this can cause a deadlock (which can on=
ly
    be resolved when the lease timer on the server expires).
    One of the problems here is that the client is sending no lease key,
    even if it has a lease for the file. This patch fixes the problem by
    reusing the existing lease key on the file for rename, unlink and set p=
ath
    size compound operations so that the client does not break its own leas=
e.

    A very trivial example could be a set of commands by a client that
    maintains open handle (for write) to a file and then tries to copy the
    contents of that file to another one, eg.,

    tail -f /dev/null > myfile &
    mv myfile myfile2

    Presently, the network capture on the client shows that the move (or
    rename) would trigger a lease break on the same client, for the same fi=
le.
    With the lease key reused, the lease break request-response overhead is
    eliminated, thereby reducing the roundtrips performed for this set of
    operations.

    The patch fixes the bug described above and also provides perf benefit.

    Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h index 844a=
fda090d05..0870a74a53bf1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -374,7 +374,8 @@ struct smb_version_operations {
                            struct cifs_open_info_data *data);
        /* set size by path */
        int (*set_path_size)(const unsigned int, struct cifs_tcon *,
-                            const char *, __u64, struct cifs_sb_info *, bo=
ol);
+                            const char *, __u64, struct cifs_sb_info *, bo=
ol,
+                                struct dentry *);
        /* set size by file handle */
        int (*set_file_size)(const unsigned int, struct cifs_tcon *,
                             struct cifsFileInfo *, __u64, bool); @@ -404,7=
 +405,7 @@ struct smb_version_operations {
                     struct cifs_sb_info *);
        /* unlink file */
        int (*unlink)(const unsigned int, struct cifs_tcon *, const char *,
-                     struct cifs_sb_info *);
+                     struct cifs_sb_info *, struct dentry *);
        /* open, rename and delete file */
        int (*rename_pending_delete)(const char *, struct dentry *,
                                     const unsigned int);
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h index 99=
6ca413dd8bd..e9b38b279a6c5 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -404,7 +404,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned int=
 xid,
                                     __u32 pid_of_opener);
 extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
                         const char *file_name, __u64 size,
-                        struct cifs_sb_info *cifs_sb, bool set_allocation)=
;
+                        struct cifs_sb_info *cifs_sb, bool set_allocation,
+                        struct dentry *dentry);
 extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tc=
on,
                              struct cifsFileInfo *cfile, __u64 size,
                              bool set_allocation);
@@ -440,7 +441,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, str=
uct cifs_tcon *tcon,
                        const struct nls_table *nls_codepage,
                        int remap_special_chars);
 extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-                         const char *name, struct cifs_sb_info *cifs_sb);
+                         const char *name, struct cifs_sb_info *cifs_sb,
+                         struct dentry *dentry);
 int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
                  struct dentry *source_dentry,
                  const char *from_name, const char *to_name, diff --git a/=
fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c index 01e89070df5ab..3011=
89ee1335b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -738,7 +738,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tc=
on *tcon,

 int
 CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char =
*name,
-              struct cifs_sb_info *cifs_sb)
+              struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
        DELETE_FILE_REQ *pSMB =3D NULL;
        DELETE_FILE_RSP *pSMBr =3D NULL;
@@ -4993,7 +4993,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct ci=
fs_tcon *tcon,  int  CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon=
 *tcon,
              const char *file_name, __u64 size, struct cifs_sb_info *cifs_=
sb,
-             bool set_allocation)
+             bool set_allocation, struct dentry *dentry)
 {
        struct smb_com_transaction2_spi_req *pSMB =3D NULL;
        struct smb_com_transaction2_spi_rsp *pSMBr =3D NULL; diff --git a/f=
s/smb/client/inode.c b/fs/smb/client/inode.c index 4c3dec384f922..0aba29d2c=
5a2e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1849,7 +1849,7 @@ int cifs_unlink(struct inode *dir, struct dentry *den=
try)
                goto psx_del_no_retry;
        }

-       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb);
+       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry);

 psx_del_no_retry:
        if (!rc) {
@@ -2800,7 +2800,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)

 static int
 cifs_set_file_size(struct inode *inode, struct iattr *attrs,
-                  unsigned int xid, const char *full_path)
+                  unsigned int xid, const char *full_path, struct dentry *=
dentry)
 {
        int rc;
        struct cifsFileInfo *open_file;
@@ -2851,7 +2851,7 @@ cifs_set_file_size(struct inode *inode, struct iattr =
*attrs,
         */
        if (server->ops->set_path_size)
                rc =3D server->ops->set_path_size(xid, tcon, full_path,
-                                               attrs->ia_size, cifs_sb, fa=
lse);
+                                               attrs->ia_size, cifs_sb, fa=
lse, dentry);
        else
                rc =3D -ENOSYS;
        cifs_dbg(FYI, "SetEOF by path (setattrs) rc =3D %d\n", rc); @@ -294=
1,7 +2941,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *att=
rs)
        rc =3D 0;

        if (attrs->ia_valid & ATTR_SIZE) {
-               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
+               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, dir=
entry);
                if (rc !=3D 0)
                        goto out;
        }
@@ -3108,7 +3108,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct i=
attr *attrs)
        }

        if (attrs->ia_valid & ATTR_SIZE) {
-               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
+               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, dir=
entry);
                if (rc !=3D 0)
                        goto cifs_setattr_exit;
        }
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c index 05=
818cd6d932e..69f3442c5b963 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -98,7 +98,7 @@ static int smb2_compound_op(const unsigned int xid, struc=
t cifs_tcon *tcon,
                            __u32 desired_access, __u32 create_disposition,
                            __u32 create_options, umode_t mode, struct kvec=
 *in_iov,
                            int *cmds, int num_cmds, struct cifsFileInfo *c=
file,
-                           struct kvec *out_iov, int *out_buftype)
+                           struct kvec *out_iov, int *out_buftype, struct =
dentry *dentry)
 {

        struct reparse_data_buffer *rbuf;
@@ -115,6 +115,7 @@ static int smb2_compound_op(const unsigned int xid, str=
uct cifs_tcon *tcon,
        int resp_buftype[MAX_COMPOUND];
        struct smb2_query_info_rsp *qi_rsp =3D NULL;
        struct cifs_open_info_data *idata;
+       struct inode *inode =3D NULL;
        int flags =3D 0;
        __u8 delete_pending[8] =3D {1, 0, 0, 0, 0, 0, 0, 0};
        unsigned int size[2];
@@ -152,6 +153,15 @@ static int smb2_compound_op(const unsigned int xid, st=
ruct cifs_tcon *tcon,
                goto finished;
        }

+       /* if there is an existing lease, reuse it */
+       if (dentry) {
+               inode =3D d_inode(dentry);
+               if (CIFS_I(inode)->lease_granted && server->ops->get_lease_=
key) {
+                       oplock =3D SMB2_OPLOCK_LEVEL_LEASE;
+                       server->ops->get_lease_key(inode, &fid);
+               }
+       }
+
        vars->oparms =3D (struct cifs_open_parms) {
                .tcon =3D tcon,
                .path =3D full_path,
@@ -747,7 +757,7 @@ int smb2_query_path_info(const unsigned int xid,
        rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
                              FILE_READ_ATTRIBUTES, FILE_OPEN,
                              create_options, ACL_NO_MODE, in_iov,
-                             cmds, 1, cfile, out_iov, out_buftype);
+                             cmds, 1, cfile, out_iov, out_buftype, NULL);
        hdr =3D out_iov[0].iov_base;
        /*
         * If first iov is unset, then SMB session was dropped or we've got=
 a @@ -779,7 +789,7 @@ int smb2_query_path_info(const unsigned int xid,
                rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
                                      FILE_READ_ATTRIBUTES, FILE_OPEN,
                                      create_options, ACL_NO_MODE, in_iov,
-                                     cmds, num_cmds, cfile, NULL, NULL);
+                                     cmds, num_cmds, cfile, NULL, NULL, NU=
LL);
                break;
        case -EREMOTE:
                break;
@@ -811,7 +821,7 @@ smb2_mkdir(const unsigned int xid, struct inode *parent=
_inode, umode_t mode,
                                FILE_WRITE_ATTRIBUTES, FILE_CREATE,
                                CREATE_NOT_FILE, mode,
                                NULL, &(int){SMB2_OP_MKDIR}, 1,
-                               NULL, NULL, NULL);
+                               NULL, NULL, NULL, NULL);
 }

 void
@@ -836,7 +846,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *nam=
e,
                                 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
                                 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
                                 &(int){SMB2_OP_SET_INFO}, 1,
-                                cfile, NULL, NULL);
+                                cfile, NULL, NULL, NULL);
        if (tmprc =3D=3D 0)
                cifs_i->cifsAttrs =3D dosattrs;
 }
@@ -850,25 +860,26 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *=
tcon, const char *name,
                                DELETE, FILE_OPEN, CREATE_NOT_FILE,
                                ACL_NO_MODE, NULL,
                                &(int){SMB2_OP_RMDIR}, 1,
-                               NULL, NULL, NULL);
+                               NULL, NULL, NULL, NULL);
 }

 int
 smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *na=
me,
-           struct cifs_sb_info *cifs_sb)
+           struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
        return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN=
,
                                CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT=
,
                                ACL_NO_MODE, NULL,
                                &(int){SMB2_OP_DELETE}, 1,
-                               NULL, NULL, NULL);
+                               NULL, NULL, NULL, dentry);
 }

 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tc=
on,
                              const char *from_name, const char *to_name,
                              struct cifs_sb_info *cifs_sb,
                              __u32 create_options, __u32 access,
-                             int command, struct cifsFileInfo *cfile)
+                             int command, struct cifsFileInfo *cfile,
+                                 struct dentry *dentry)
 {
        struct kvec in_iov;
        __le16 *smb2_to_name =3D NULL;
@@ -883,7 +894,7 @@ static int smb2_set_path_attr(const unsigned int xid, s=
truct cifs_tcon *tcon,
        in_iov.iov_len =3D 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX=
);
        rc =3D smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
                              FILE_OPEN, create_options, ACL_NO_MODE,
-                             &in_iov, &command, 1, cfile, NULL, NULL);
+                             &in_iov, &command, 1, cfile, NULL, NULL, dent=
ry);
 smb2_rename_path:
        kfree(smb2_to_name);
        return rc;
@@ -902,7 +913,7 @@ int smb2_rename_path(const unsigned int xid,
        cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile=
);

        return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
-                                 co, DELETE, SMB2_OP_RENAME, cfile);
+                                 co, DELETE, SMB2_OP_RENAME, cfile, source=
_dentry);
 }

 int smb2_create_hardlink(const unsigned int xid, @@ -915,13 +926,14 @@ int=
 smb2_create_hardlink(const unsigned int xid,

        return smb2_set_path_attr(xid, tcon, from_name, to_name,
                                  cifs_sb, co, FILE_READ_ATTRIBUTES,
-                                 SMB2_OP_HARDLINK, NULL);
+                                 SMB2_OP_HARDLINK, NULL, NULL);
 }

 int
 smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
                   const char *full_path, __u64 size,
-                  struct cifs_sb_info *cifs_sb, bool set_alloc)
+                  struct cifs_sb_info *cifs_sb, bool set_alloc,
+                  struct dentry *dentry)
 {
        struct cifsFileInfo *cfile;
        struct kvec in_iov;
@@ -934,7 +946,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_=
tcon *tcon,
                                FILE_WRITE_DATA, FILE_OPEN,
                                0, ACL_NO_MODE, &in_iov,
                                &(int){SMB2_OP_SET_EOF}, 1,
-                               cfile, NULL, NULL);
+                               cfile, NULL, NULL, dentry);
 }

 int
@@ -963,7 +975,7 @@ smb2_set_file_info(struct inode *inode, const char *ful=
l_path,
                              FILE_WRITE_ATTRIBUTES, FILE_OPEN,
                              0, ACL_NO_MODE, &in_iov,
                              &(int){SMB2_OP_SET_INFO}, 1,
-                             cfile, NULL, NULL);
+                             cfile, NULL, NULL, NULL);
        cifs_put_tlink(tlink);
        return rc;
 }
@@ -998,7 +1010,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_=
info_data *data,
                cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile=
);
                rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
                                      da, cd, co, ACL_NO_MODE, in_iov,
-                                     cmds, 2, cfile, NULL, NULL);
+                                     cmds, 2, cfile, NULL, NULL, NULL);
                if (!rc) {
                        rc =3D smb311_posix_get_inode_info(&new, full_path,
                                                         data, sb, xid);
@@ -1008,7 +1020,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open=
_info_data *data,
                cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile=
);
                rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
                                      da, cd, co, ACL_NO_MODE, in_iov,
-                                     cmds, 2, cfile, NULL, NULL);
+                                     cmds, 2, cfile, NULL, NULL, NULL);
                if (!rc) {
                        rc =3D cifs_get_inode_info(&new, full_path,
                                                 data, sb, xid, NULL);
@@ -1036,7 +1048,7 @@ int smb2_query_reparse_point(const unsigned int xid,
                              FILE_READ_ATTRIBUTES, FILE_OPEN,
                              OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
                              &(int){SMB2_OP_GET_REPARSE}, 1,
-                             cfile, NULL, NULL);
+                             cfile, NULL, NULL, NULL);
        if (rc)
                goto out;

diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h index b3=
069911e9dd8..221143788a1c0 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -75,7 +75,8 @@ int smb2_query_path_info(const unsigned int xid,
                         struct cifs_open_info_data *data);
 extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tc=
on,
                              const char *full_path, __u64 size,
-                             struct cifs_sb_info *cifs_sb, bool set_alloc)=
;
+                             struct cifs_sb_info *cifs_sb, bool set_alloc,
+                                 struct dentry *dentry);
 extern int smb2_set_file_info(struct inode *inode, const char *full_path,
                              FILE_BASIC_INFO *buf, const unsigned int xid)=
;  extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inod=
e, @@ -91,7 +92,8 @@ extern void smb2_mkdir_setinfo(struct inode *inode, co=
nst char *full_path,  extern int smb2_rmdir(const unsigned int xid, struct =
cifs_tcon *tcon,
                      const char *name, struct cifs_sb_info *cifs_sb);  ext=
ern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
-                      const char *name, struct cifs_sb_info *cifs_sb);
+                      const char *name, struct cifs_sb_info *cifs_sb,
+                          struct dentry *dentry);
 int smb2_rename_path(const unsigned int xid,
                     struct cifs_tcon *tcon,
                     struct dentry *source_dentry,

