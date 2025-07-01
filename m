Return-Path: <stable+bounces-159123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4457AEEF59
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A4517EA16
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409DB247290;
	Tue,  1 Jul 2025 07:03:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41222FE0F;
	Tue,  1 Jul 2025 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353399; cv=none; b=dNjbajtMXBRnotj3k+UYiiV8zV+oNw/qtAsEwskJ05KhZh4eCVJ9uLx/9k8YZHnOnYwS2vmHLH6o30lR00eGXTluinqLfMVyzZzQGNrwcwVgrRMVgAH+PfOMESetN1esGNO2HOfLB07GV1ByLpC1aMZu6o0LRfWs0sUp1HhCPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353399; c=relaxed/simple;
	bh=ejfpJOVIN5K+OygLQzL72YQqZRYVi5tW95D8dsQO/As=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yf6Rcgbe9ou1XPMPAiOmDViXGu8kh35z+/7GeGFS0eSKohsElGL1Os0c+U1ApPcXNbZWf3XgCl+903zwhI5rapD8sGLs3ZhIF2gntp5ztcLK2kbvjcIMhGkq2uuybCP1I43iGhariXtDaYVkb6WjgRo4FgpFXIsJWo2MN+Y8JrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1751353335t209t60929
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.151.178])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5655527937148675839
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com> <20250630183127.0eea7b0b@kernel.org>
In-Reply-To: <20250630183127.0eea7b0b@kernel.org>
Subject: RE: [PATCH] net: libwx: fix the incorrect display of the queue number
Date: Tue, 1 Jul 2025 15:02:07 +0800
Message-ID: <050201dbea56$0f357410$2da05c30$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEtzzkUZBccSc4HJFOXyE1ELYYWYQE9pEdZtW8ftqA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NImvdRhE6fHpQ41SCYPOfStBbLfZabgcZYRjj64n0tyypzFw/Zy7mlc6
	3+ce0bJpa7uKdz1tge1H0OvNzzO3xj8ZYoGtrScNrwnEa/iCE72nqhUw1/F+4UX+vGyRi1w
	6iQKsCR6ujIU0JWNm1g0uSGSvYyfqB2taO1d30L3Ri9ZftADINY+MuvLKIgCJmWJanNYLDT
	BtTIRtXPVeYp2UnT2uOZegycB0VIz03240jdjDOyxKvOPxnRmEDbyhIu/pHVFfmAr/3VT9E
	cOdMK1nqBM8yu/Ackj8JIuYj7lR0qVo/Qg6bzgOg3hRCr2J9IvSdTUG2+IVlqYiTBJs+hGx
	0jYMv8srwVsYbXKAViAlp83KdNDfCdFf3ZnHb8mwtkFZQ3EtYFxJRSWloabjjoC8IocskDp
	KNXSEnVGViQaqNedOaXU/SLb0Y64/q0bMiKqn7nHhPqOvQYFZYbRGBvYGw4oxmO/zTxv9rk
	Y+wQGuXekbkmej3IsXvIZsyO+Ix+PG1XXpZ5gU8JRuPRbVzSv2oDPk6egCvHFBZXuTH5NCY
	7cfxY0aL2V4EMY4EtAV1MZB8IqsbBp/IcjgTn7xeZicfmnaChcPR2JfWkG7OEtnhf8LoXkO
	vE64fHra69hae8tTUM91MEIBnQ/p8RY88L2qc+sWkOAr7k6YQh9ZxFe82lvl98RJRB9REJo
	IsPcIZjTHO+bxCb1ugLjF7TyaN3rzzCoMfVQ1wbw9TdSNwXpPl5S7iOpzaw5FRs09EJ7z0U
	Khix5sn34BHHNb2LkjEQdEr6/prwWNWVWdjaL6ZR+7ucmUTjTsZcrBJTwL3YypnXQzs+9eE
	2Lo0dCiKYOc8kMGL+j/1aCOpRjae4yhKB30yww7kKv7wvTu5uTJx7N1+pAkGQwe2QLYHhug
	DH7yQgX/dDckpuaSlilzN/89uDYbdmky5piUvuqIZRm62fdzhxuF3XkxW4xdItNH0cxyUg5
	vJi+CH0E2Sc/vMztCWxh9XsRmhtno0ctIKCcyu7y1zBOrEFo7eJ47pffXFHbG/6L0ElY2zk
	ISZ1bTVszu2TtJe5ObGhaj/lKRQMlMTDkBJ3HAMw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Jul 1, 2025 9:31 AM, Jakub Kicinski wrote:
> On Fri, 27 Jun 2025 16:09:38 +0800 Jiawen Wu wrote:
> > When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
> > changed to be 1. RSS is disabled at this moment, and the indices of FDIR
> > have not be changed in wx_set_rss_queues(). So the combined count still
> > shows the previous value. This issue was introduced when supporting
> > FDIR. Fix it for those devices that support FDIR.
> 
> Why are you hacking up the get_channels rather than making _F_FDIR be
> sane in all situations? I mean why not:
> 
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1709,6 +1709,7 @@ static void wx_set_rss_queues(struct wx *wx)
>          * distribution of flows across cores, even when an FDIR flow
>          * isn't matched.
>          */
> +       wx->ring_feature[RING_F_FDIR].indices = 1;
>         if (f->indices > 1) {
>                 f = &wx->ring_feature[RING_F_FDIR];
> 
> ?

This is quite reasonable, thanks.


