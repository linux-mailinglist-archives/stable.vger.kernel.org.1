Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A5718AC9
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEaUIZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEaUIY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 16:08:24 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175B12B
        for <stable@vger.kernel.org>; Wed, 31 May 2023 13:08:23 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VGOGhJ031494
        for <stable@vger.kernel.org>; Wed, 31 May 2023 20:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=eF5TFHbvRvWr0+Zc0z0qbXO+ookp3if7gbCu7GS/M7c=;
 b=jjtB0MKgctHrk7rZ6vttzAg7/swKdzSN9+rE8gEJQzGIcSLndtVsxZTptX52KGSx6sT/
 ux38Tc5ROF7um4rhE1rI8BDMkkPKYeK0rp9x1Nv5J1SNrEE3027XepMX7cR4bwIYBbvs
 SN7uzr5fddOE9EKOyybaNFUVqzgrwSnQV156ZrtuMPbribXuCloHcRY6BxfTNZ63OPqH
 1i1MLlw6nqmLEWGLw/dBGSSgETP4f+9UlNc+6/AF5rwLwC1pSdEBTW1BY+a3mqj7dMut
 2YpSOvwX0TFgf9XPHSdLc2ryzK9y4Q9mTdcxicqCmSRwSs6NYfu/Mo+p4v4wY8h117Ge xw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3qx9qhhpmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 31 May 2023 20:08:04 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 05E7612B41
        for <stable@vger.kernel.org>; Wed, 31 May 2023 20:08:03 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C68CF806B6B;
        Wed, 31 May 2023 20:08:03 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id E37F8302F4727; Wed, 31 May 2023 15:08:02 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.15.y] platform/x86: ISST: Remove 8 socket limit
Date:   Wed, 31 May 2023 15:08:02 -0500
Message-Id: <20230531200802.2134349-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2023052848-preset-slapping-3df7@gregkh>
References: <2023052848-preset-slapping-3df7@gregkh>
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-ORIG-GUID: 9ChP8i8ZLhJkswTmwfrYb8Ou0cOrk8sa
X-Proofpoint-GUID: 9ChP8i8ZLhJkswTmwfrYb8Ou0cOrk8sa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310170
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Stop restricting the PCI search to a range of PCI domains fed to
pci_get_domain_bus_and_slot().  Instead, use for_each_pci_dev() and
look at all PCI domains in one pass.

On systems with more than 8 sockets, this avoids error messages like
"Information: Invalid level, Can't get TDP control information at
specified levels on cpu 480" from the intel speed select utility.

Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230519160420.2588475-1-steve.wahl@hpe.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
(cherry picked from commit bbb320bfe2c3e9740fe89cfa0a7089b4e8bfc4ff)
---
 .../x86/intel/speed_select_if/isst_if_common.c        | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e8424e70d81d..ab8254d75b76 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -287,14 +287,14 @@ struct isst_if_cpu_info {
 };
 
 static struct isst_if_cpu_info *isst_cpu_info;
-#define ISST_MAX_PCI_DOMAINS	8
 
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *_pci_dev = NULL;
 	int no_matches = 0;
-	int i, bus_number;
+	int bus_number;
 
 	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
 	    cpu >= num_possible_cpus())
@@ -304,12 +304,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (bus_number < 0)
 		return NULL;
 
-	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
-		struct pci_dev *_pci_dev;
+	for_each_pci_dev(_pci_dev) {
 		int node;
 
-		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
-		if (!_pci_dev)
+		if (_pci_dev->bus->number != bus_number ||
+		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
 			continue;
 
 		++no_matches;
-- 
2.26.2

