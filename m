Return-Path: <stable+bounces-204338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB7CEBE8E
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CDDB3020171
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEB311C2E;
	Wed, 31 Dec 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSfdNKjy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V2uOhDMI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B75320CDF
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182998; cv=none; b=P1gXXnXVdRN4rTwlnrmVdWJUGIx/9tJXiSltWYkKTcaQg9cF+MJp4ZtDRQiY4BR+X6+xk41PFqXWrpH/dAkEGCv7nP5qE59a5mtWp5F43Fmt6AcjhyloOy1ByO5nuVXqIs2RDcx1yVbceAZ5+gEfidsAXQOfq3z1EMtHCs9izmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182998; c=relaxed/simple;
	bh=5DEfcZOyj8V4UV0lwZrci3UolInf8HpdmaZjhrBFUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0Xi8SqU6JtSjh63VBZe21FM0DrizHRw78dlVb+GFOq/tNOtYapeRaGFfdUL1cfq37+68o1SLsWulRyKZOSLgxyYexe4JVyjU7OPsZf3a7DGPvKecJe0W5jcbeKX9XQOTNl+auudwJMPmsNn6GkehANeEcpdrzzIGawsHUmSvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lSfdNKjy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V2uOhDMI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNwUEG2723263
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 12:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jn7W6f4QETcyt7wP/Sf3IytnEriKXlUE3it
	Qrm5nw1g=; b=lSfdNKjyXTGW9S+qkt/LlU325fze7ucDbRlUBUYfKEpIUSVrODM
	1vkByIMVbiNVBRKkr/keStxLpMzzIsiW7wC8AvoFLwjNpRW5tm8BLVwowbjG72CP
	khfDEfSHzm+3T2kRrsvG7YpqlYg+9txFvM8dazdOv1/bGxxlnlDUjXmWQJU4mmnh
	yIqv8Mx02jtTbNN7rK4usDmt7MzUYJn/Ho/Vh4WizV5mACpDLjkfNYIHIDqC0ai6
	Di6cNg7e4l/0ibsC7gH+DxAqJSh9jya3xQa7h0fyiICl70FF9lo97AzfffFjd92j
	3FOFUTVQn8vpHj9RCjYdATqDQ4dxsZdUMfQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdm9b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 12:09:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1f42515ffso271847431cf.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 04:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182995; x=1767787795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn7W6f4QETcyt7wP/Sf3IytnEriKXlUE3itQrm5nw1g=;
        b=V2uOhDMIoTWZObhjR3AxTnV+GVEoze38OGgz8TktmbhreKzfSnpMIMkLUAAk0ql2Sq
         XcN7tbwHjoqJXcXJ7++SeOTUcZyMfoKBc0udWsmv6C3R1vR57v9nAQmNhdDqlmNWMOhh
         HCs6ITExMkikaktF+XQApIqhIbg0I1qPqL/dXXjkmQnGNsTOK/bzX1qc4DryDiqEtlAX
         QZ5AHLFXNaiOUxnibCjGtr3wpdOmukNvgIA7uTdqpkeyt3OFxKX1pPRB2Xn81QGFALdB
         VB5WW1bcQBCdhKcSH2m2DoqfrUuyZ4jYTd2vV0oHmTqStfpuOpvS95nK8LIijUpekkHd
         ABVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182995; x=1767787795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn7W6f4QETcyt7wP/Sf3IytnEriKXlUE3itQrm5nw1g=;
        b=EfzFayWC87GqDU2JRlUFuzwgIVvFcPfUtgD8aVjs1sXC55kRLicRC1u7mnWPfr+IBs
         WVXdSRX1e68qIRabPzkb/b9MGdpa56Ec7+smTEjsOPEh8EMGfhFzMa/mMFKAATeJbqj2
         5mF+Dm0qc3uXRUqcsEA3agbpgMuJcf63o6Achq8mCqqhxiOqrfdeBVrduNraAEbkrCyl
         R4jdMbd37j1R1GAYlNR447pXoCFYFbR7OhIvO7WWgUkOq8Dx6OWpLpg82lIJSaXasuat
         zFdZY2SzXVUplsP0t6MnethjARsPBGBGBUy2uzgBHs4mjkOhvISGjb6i/bXe0+Bvpp4Y
         V2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV3c+5qVY1kLFxOHIr2vD413WbQ80JWfbwpjZuwqnlNC3hdqDGOIhjlm67qMDjzur66hZugnIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeIXHZEPZzm94Zv4l/NTuFJmT9DBuTEaZevbHQQZZJcxCuNL8
	3eOsCM9JmBlbtEtgWqQGZ6SiPSA3yPaTE0qwOj0p8rta2EROYmbXW2oFKH01MSRWGo5boQjOt74
	ocLDXXDmT5weOom1fpoJbA+hx/FRKcDLc7ANhkZAkbrnfaSJ9R1lAfr0AaQQ=
X-Gm-Gg: AY/fxX4N5XG3MXUEtxbgJ5k3GMdV6NuBQLbFlErFT2ORsKJZYjSqbl0j3HXyAtFRZFv
	NjMEiG3e0aK2QDnYLBhMGDO7Pg/HzG5furCUcuZ/ThC9fsPTfYS6Fqiap/v0he5RaIwMtNqCGLM
	Wu9DztUOBh/IZygRc8RlddG3E3TcrztlYSQS2IY7gJmpyzoSJgzK2D6QhLHuNJFV//20dUSr8U3
	eQE3PgXD/fOq02HfUoP80QHmHsSKPG20if2Xn0XAMyGkiOwUPW0jJgL7iN8CtZaxpzQNZ+WvdwM
	aRsmqMOwHDMAUFUwTP6VU2KIAATUC7x4OFDuPjHO4FhvmcJasjcuQytBApY68wYaA7ME2Ol65Xc
	GvWZ7l0+NfpDSQVd4t3mCpmraZQ==
X-Received: by 2002:ac8:5cd5:0:b0:4f3:5658:5428 with SMTP id d75a77b69052e-4f4abd78fc0mr544520321cf.38.1767182995047;
        Wed, 31 Dec 2025 04:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEXffLyoka5LLXxyBDKnhZgLx1Xw3TVtp1KZYsKEeATV+84OUAiwAJW4n2pVu1RqxU4HSPtw==
X-Received: by 2002:ac8:5cd5:0:b0:4f3:5658:5428 with SMTP id d75a77b69052e-4f4abd78fc0mr544520011cf.38.1767182994568;
        Wed, 31 Dec 2025 04:09:54 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm64020464f8f.21.2025.12.31.04.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 04:09:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>, Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] nvmem: Drop OF node reference on nvmem_add_one_cell() failure
Date: Wed, 31 Dec 2025 13:09:50 +0100
Message-ID: <20251231120949.66744-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=5DEfcZOyj8V4UV0lwZrci3UolInf8HpdmaZjhrBFUgg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpVRKNCHbu1ziDul8Sq6XK8e2e+1nG9ZryvwvGX
 fcNzaJH/5mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVUSjQAKCRDBN2bmhouD
 1/syD/9rfG0kBDOZh9MSeM5XfyUGc/W7psXUxiLEkkp0B/p1sAQSOK4KggHaeUc2AxXKWNxJA1z
 dwyjYV4HKBRKQmAA61CsgbpLWGom5Ln3Pou0+ZNhLDK05Zhq3zYipRp/d/LKYkNgddy1cTgfWMm
 P/3Quw1LwYTqc/3Q8lLF839FktEhc8m8uiM9eIY+52bb/J7BSv6po9hmj3kFxJGsHX3qHE1iI7I
 1o3FEFvkxXhNv+826EF7Fz3O8cDiIG0SeGiLvVPQ38rj4VmbzLmceYOXPRelxbOQhdaembQeSSq
 4QuegXfjOG3d58ruC6fm7ZF7TUuBk/am930OoXb+C+IHdxg6gvH22WEWu+Eag8VoZdHkX4eu+b1
 b14l9wMzGeRlBdvFV6iTWXeGyDeokwhJtxWb7qytX4jM155HUsET0Y0Orgeq2phWTLpBeLONJ9k
 6Vlt7XPo3uAzgl9jMFKb0N2ytvrAaIb0SsSgpV8KwG3FU8Gcx4aDiu3yoOkcL8pn4vPtQhcceZA
 zWjDRQmMbRN91wL5LEuUUIMUm6SLW+TvjV+Mey25fjusOoEpyAxyhVin4yOMjVIMr6wA+f9HQ9j
 qigrcR0AHW4PHke4iSs8gzRafPfqAOkMYnCx2/OLEJFNr8o8f0t3R3EqOTNxMUjfr5zlJekUFcP sFyXVk2wCEMdD/g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=69551293 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5_h1-5iWDQaZzP7Q6esA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfX69tjpSkqzZOl
 KXaonyXvUXZQfQP5Fst7GTi9Esf3kxSWpjTd2HfGMpssVT1RcqbemF6aNF7vfrAtoqEMNoCmx4a
 Rc8yFbNu7kT69R6MGFAepLQ5IEeJeMRGzeBfn6gTWl4bSlfYpA3rErm+fho9yCQk9IMvslsXKF+
 Ur8bbDN1mcOuv6Mm9G/dYDzuhvIrFK1d4/spSKVD9cXgvMzJBaQHcYyG4r3TnWSx8TWdatlPKb6
 b4Hlogemkf8y1bEvi+dnrzlP4jFHdDnt4yG698dhius/hx91MV3x8WpTxYRQWhpj7WQkA0JH7qC
 APnh/0dNI64lAAg/UhJmO4SS5kIfxXIlnVcz4BySsWKri2M45NOlBh+mnk1DKYL8kn9OFwYdPry
 k8FVxzLzvyoDk0zk6+VvZNPt2PFniZJldr5EaiHCnqAFbVBCNAhLG3+zgNH6kLljW4KasVCoyq1
 7XPs0f6QBGGAoqcPRvA==
X-Proofpoint-GUID: q9sHFlXUJlTRwuishq4vg3O1R7yo6le1
X-Proofpoint-ORIG-GUID: q9sHFlXUJlTRwuishq4vg3O1R7yo6le1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

If nvmem_add_one_cell() failed, the ownership of "child" (or "info.np"),
thus its OF reference, is not passed further and function should clean
up by putting the reference it got via earlier of_node_get().  Note that
this is independent of references obtained via for_each_child_of_node()
loop.

Fixes: 50014d659617 ("nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c55259..ff68fd5ad3d6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -831,6 +831,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		kfree(info.name);
 		if (ret) {
 			of_node_put(child);
+			of_node_put(info.np);
 			return ret;
 		}
 	}
-- 
2.51.0


