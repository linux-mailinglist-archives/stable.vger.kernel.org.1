Return-Path: <stable+bounces-65347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F1946E69
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87591F21F24
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439EB2C87A;
	Sun,  4 Aug 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="j0pXGFBU"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06011601.me.com (mr85p00im-zteg06011601.me.com [17.58.23.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A702557F
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771075; cv=none; b=LF8Jkq1s9yfOQk9cbO2npGoIgU8eB/f7SG3VGdhD3xpaTJ/SMmkTqN0omG/IHvvASqI7sty2v5GSraQ+kyVvUxbIDk4AGhv/q5Z9rTLD2mTfZG+TAsIhJuRqOVCqhhcEHCJUk7w42esML8a6eOXEebEm2eqq3bX+yUhzPbRgT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771075; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=J4PAL/+UO6KWvzwIFvpAkHAc93GPxIKX60M42UzoCoQWozbWClrMVmZ2AJJN8+Vu/NwwnWyqB0BCUwxQ7aKWfvw/PIf3AdZWcUghBAfkYo+CW3IblAfIq+6lQuJurRnJHxXxP+w4EcF2IY1bFN74ZzIplUVo5b2TfuQjmQ+aquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=j0pXGFBU; arc=none smtp.client-ip=17.58.23.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722771073;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=j0pXGFBUkuST4aGUnxYaN4QYsXXTsKyNVQbh+CO4T9xDOZagyI7eC9FpAk87UKb5Q
	 +JSXpW8lX0LPhkGFKH2l95ZLbnntJNkYhKxCFYukHEcNIFAynsBbQ05RXSXogUglky
	 qYlIlxllaq7Oig8NSr2i7HuuYL7xCLKmsXtR8sNxRNudvTMzc0TI1zfN6Gxl7NaKIF
	 lOqw8qRGDlsC273rMgzDUQfUZUVaE5769DKzZoZurj8wYFuKZ2Fak4N4GNySD4EmEA
	 r0QDBTcYA6SKrZLCRq0CQP4FPnNQTXxXgOAvDReZU+UYkY//R2ZnOtj7geVQarF2iN
	 ZaHWUbN30HxfA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id B1827180036;
	Sun,  4 Aug 2024 11:31:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Jasoor WW <jasoor777@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 4 Aug 2024 16:01:02 +0430
Subject: Re: [PATCH 3.2 054/102] iscsi-target: avoid NULL pointer in iscsi_copy_param_list failure
Message-Id: <62401A5F-A8A7-479F-8351-06E03A7A6489@icloud.com>
Cc: akpm@linux-foundation.org, joern@logfs.org, linux-kernel@vger.kernel.org,
 nab@linux-iscsi.org, stable@vger.kernel.org
To: ben@decadent.org.uk
X-Mailer: iPhone Mail (19H386)
X-Proofpoint-GUID: 2cKBbkR8QSy7Fj4iFNakX_iKhegw-lr-
X-Proofpoint-ORIG-GUID: 2cKBbkR8QSy7Fj4iFNakX_iKhegw-lr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_08,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=486 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408040084



Sent from my iPhone

