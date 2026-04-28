Return-Path: <stable+bounces-241685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFd9EbTb8Gn3aQEAu9opvQ
	(envelope-from <stable+bounces-241685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880948883F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A23F0303E1A5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AE44105E;
	Tue, 28 Apr 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="coYLlRjw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQV6Svyk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35D43E9DF
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387819; cv=none; b=LOEAJWFcgyhkTrvpTucmo6GBVWpKbbKkdzQrUFhbU6plANCrtwYdNZ53urFVslbml8UVVJnxn+PLDNHjPNcX+j2ajlooSwwnSKU66w0gmjxIDLlMBoHmnbxPxZLUmsflTGZkvwpar53k1CEmT5jstJTZwPtJUFbx0ToQRs1ZImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387819; c=relaxed/simple;
	bh=SVWhDf4kcVCdjVPrhFzP6H9j1M1oo0iuBo0Bp/Jbnd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHB90+fldt8lZpym85vKzZrmyALjSXY4wZul50+3phBdbsBr/rPiVAVun/duKN+vv2ia/CGkYZ1aYV5zV8UApQe1AG57Yzr4fsXMLPqYF/9LuB2P0bSzvjhUOzg/0dVk2kDeoEDgq/F4X2MVmAYP5WRlWhaZPqSGATWKlsvr1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=coYLlRjw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VQV6Svyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA2t0U984995
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GsIBwYF3/hB22gmEUX2AWGJXtaU07hGbH8f
	Vy9TATio=; b=coYLlRjw0N1Jzc0VbhuK4ah6yLIuwqsStFKJd6eFVjlcin8MO0r
	fGMUokMnTS3u2Qdtoi5nWQxxbrd8PQeJqtXjeu5A/sVGVKKhCnbJv1v5jXni8cBf
	JVrOiQ+vHUunyTqw5Cqfdz1sGZxQXaoBzVEs8d9IXrYTmnee+pw+C5UxaPe+RI0x
	EXdJk033Qd8y7ZLorJhaoOt4/iNLQEkvLcQ6ABG61fY4af6Llk8Xsbc+2VE2a5ej
	N1sWgjM/K5cY86Hgv8fsuUwMEwZaF4W3HORA2sFGb7JcJHxcf84vPKUQZQk0lUPv
	TwukpfYFmbcYW0WQ0jiZPpHHrAV8nz4yvWA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2s60u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:50:15 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6056898a01dso14740974137.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777387814; x=1777992614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsIBwYF3/hB22gmEUX2AWGJXtaU07hGbH8fVy9TATio=;
        b=VQV6SvykIYgtUByj2AG6ZYA0psQki4WT2S+2rXO9o6ofiX22H9HtyR0o7sB1OLxjFt
         UveukhGJ7J9PxgbjIhFnQCZNJ5tt6xm+R+c1LQjk4YlsoiNVorMEBbE4VH0/g8ZMRtzM
         Wyp30ZDm4vZKUTglAxCd0JVqHQBhLb7qOeeQrEJi1C+1iTBeItiCINgZkU5BdvG4I7rJ
         VJw4dEguGgjH08UkXLtnrf8x9yezzxVojDIOIthe4bEVl0HsZJ1EJ5i+R3O01/aPBatR
         RMbsHwvmH8GowNrWHxs6ekYXcsFu9DfAVUaADbj/kGTArlOXA7CUURY7eOVbWCuWu63J
         i84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387814; x=1777992614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsIBwYF3/hB22gmEUX2AWGJXtaU07hGbH8fVy9TATio=;
        b=Vo6rY3T0ix2H4uV9NKbK0K4fgBsqt3vg1XZADIsaF8qLA2U+jDlBIFX94QqiO4Fm5D
         zaWiWLRFAIQb9vkYmg+Ic2oX92eQ6qoHhggNybH02EjnLzBD8+uazMfM+h6AJ/HCBHZO
         S5uZMuEw3mJTw65V1KQ2O0RiRx/8jjK4+DJ/UEUkeOj7UsyIyxcAJ4TXgWu5amr7NBAs
         9cx0/OcEUo7hUlHFLA/iPchXcdQOtwnSg+Bk5HK17HJA/NNU7eZdPG8af2419Fb8UeDi
         vb3+UosmDFQe6KoHxW0CtSKFFTwLNDJ29vJeWMitWGNnGpkzXspxxJtTNrWx3ggQcRv0
         1sUw==
X-Forwarded-Encrypted: i=1; AFNElJ8ykXcdeyVGuaU7cDkjnYWWlQErgIHku52uJNfq94B4P48t4dHEhT51AQgjBxIComa0wEgoeq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsNBzhoKj62VnTbVG8RLG5qjBLc+IUBHaDBJzJ8dkPPBMsMcS
	ZvWfoXSSdNNP9wS8Ne26ITs59wiirEc/npAPjjePZO8uBYoyzHeRSiBAR5nJArhGthlWMRcyQA1
	CCDaXoGTLnCH2SrEsXNlGEOW8LaDtIJtXQss9ZoKAAbXHsjRzh7DQxBmdLLf3164L2is=
X-Gm-Gg: AeBDietuuAH8t0VLTaWHQbWqSfgYEclrODnB20T87uN4uljyd0d1R+MHItSnYh14XPc
	gAf2hAymYvTSsIm6pmIcMAn8OyqYkNGtLmsG09RT/M8nl9Vw/QXXd/7dcgLfN6TAutkhP2DvUlD
	H7wCfUtph/NmJQk3kGXu9DcMxw3OA49emGMi7xZThltzM/KTFM96nfff/mrsP2Way1pFqFjws+p
	xx7N1AW8iFI9MWG2uph8A/oDsLzqvwKL0PtbIraG7BDzOmYz607FwMVS4bjIGVLpvZM3WZl6xUa
	7hL17DyZEU1h2GOCUoCW13lVG86/rMg/j2ZRinnXKC0xD+JGjH4kMcgITeOwxTR15lxwB3TF7Kp
	AqfgNs9IK0miHZo5uI1cQPrwj3FaedwKA9XA8+/1goUoi1uM=
X-Received: by 2002:a05:6102:950:b0:607:7991:8edd with SMTP id ada2fe7eead31-6280a8c5705mr1632663137.19.1777387814167;
        Tue, 28 Apr 2026 07:50:14 -0700 (PDT)
X-Received: by 2002:a05:6102:950:b0:607:7991:8edd with SMTP id ada2fe7eead31-6280a8c5705mr1632637137.19.1777387813551;
        Tue, 28 Apr 2026 07:50:13 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463ff5a1acsm6761007f8f.33.2026.04.28.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:50:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Igor M. Liplianin" <liplianin@me.by>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND] media: pci: dm1105: Free allocated workqueue
Date: Tue, 28 Apr 2026 16:50:08 +0200
Message-ID: <20260428145007.116837-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=SVWhDf4kcVCdjVPrhFzP6H9j1M1oo0iuBo0Bp/Jbnd8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp8MkfIGdfILw66p32MV+z3qAJ6a2bEMshsh9H4
 nBx6uw8PkuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafDJHwAKCRDBN2bmhouD
 1wopD/92AIvFEnYO6sX5M7T6C9D5AQEFBgUUt/YE9uYzCySmQya4+AFf2Tr8kRUCIJ1FYnFlBUa
 y9BfQ0sKxnRTpfl6foN/cr4NuPSf/BmNH44JtUlqUv9HdH4lfJCrFoFJ2Yd9En7bbkvN2VHe+Rd
 IFqZXDKn8q9/XserPLgXapia5IKYR53J+N05HbpJkF0BPSQWzGCSm79DSLvXPv/4rK0NkEhY6hK
 ya13KxlWo9QMIOccP2/+ufAyvvhJisEzrGcnTtokPLpLQxwiHvsjKgN2XEbNjpM50yaQ8dmh7Xh
 HFfABhCrYcKqjndmItGLN8hWAS6qtHUBIK50xSUz+SFGjThCKbsSr8sRexypj7FtYa5vDq864Lz
 4N8bCxwijS35wtgNL5S5xw7CnI35qdcbaT2Yz+9X+bQg4mJPOx3EA0TlClLmJCuJOS9aeC3404+
 FY1YYa07rT/ErTs1/Xl0/kU4XKX5tmVNxBkM66fR0G0LJFzU/hCnJyafP4QVNvJwOjp/XksTs6h
 r2HzTNMGWZOONkkFKivyQDUWYGihC6Cfz1mitzNX+YUEO9JHh5faDCqJ2G4X0/aJeyo2iHsL18l
 D7TXRKzbpsD/g4xDSzrVcmt3UjAKHLm0+I4vWkdBrTOlMiKIGXw7Vp4C7gWJT5LTxXHjsQDduTO 7T8ntuOmkrGETDA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0c927 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LExpPkxNjxu_IcRyS8EA:9 a=zgiPjhLxNE0A:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: tLQEfUKoVKY_eKr0a03SeVnM3ljqI_ka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE0MCBTYWx0ZWRfX46O13npIBjel
 d2BpWps6f7BlbWM80lRjxTYAXyFrCUTiHf1fDYZ4w3Xrv7080tdLGQNuAJnKUW7y26HiBgWoD3e
 4I+6UhONf8qvjIA8sgd2JPr6VQMKS7xGLI+DPkwRj5Fiay2ejTp30XEtr0CaFL4aFPswK7RsCn5
 tGm/1knIhfVAm5J0dMDlq5i60TrKoZmQXVeOTggdyJhxDCwsyxcMQ97eMzkpTSVL+xX629UxPUu
 I6NmkwaMg2fEkpNBAhHcfzg8sD7eUztbQ//D2uwG+odPJoJBaTO/SCxHrOBzsqsxNdkb53Nhtfz
 djX+Bccy5j3C72KiQ3hiYz3kEZ3526dJmtDU169JW3lnD2zIqrp/LU0BeIm9JcNL2ejWA+cOHre
 SpWJnDTOz23Md5duhkNf2enzX0E6axT3GTaN5hyD73Z2qLsRxul6LVC6GTtVEOd6bXpXy7NS9S1
 DWVclm4wYBmWcR6awFQ==
X-Proofpoint-GUID: tLQEfUKoVKY_eKr0a03SeVnM3ljqI_ka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280140
X-Rspamd-Queue-Id: 7880948883F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241685-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]

Destroy allocated workqueue in remove() callback to free its resources,
thus fixing memory leak.

Fixes: 519a4bdcf822 ("V4L/DVB (11984): Add support for yet another SDMC DM1105 based DVB-S card.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/media/pci/dm1105/dm1105.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index bbd24769ae56..e915d9a3f785 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1194,6 +1194,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 
 	dm1105_hw_exit(dev);
 	free_irq(pdev->irq, dev);
+	destroy_workqueue(dev->wq);
 	pci_iounmap(pdev, dev->io_mem);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.51.0


