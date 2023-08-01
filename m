Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971D76A9D5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHAHRR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHAHRQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:17:16 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67FF173D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690874229; x=1722410229;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=fFjalAFHaAQIemFzLyHophERG99+9W5vVPyLyaq25hs=;
  b=RlA+zdRKqmXMcM/N+/4MVnxlJD2ULoC/p99EJn0IEgspiG5Cao7GcAsw
   2zqTq1riBQyKoZn5RTrYSrl5Kj61+23YXa1Ujmt4G4lLfvPx6pzhz7D1l
   oKfyl3MHUG2w8/88J+CoPxOJYJFj/3EQhfrsknaCc9JN8zZEE8kOqZym5
   I=;
X-IronPort-AV: E=Sophos;i="6.01,246,1684800000"; 
   d="scan'208";a="599511843"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 07:17:07 +0000
Received: from EX19D010EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id 24465140E97
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:17:05 +0000 (UTC)
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX19D010EUA004.ant.amazon.com (10.252.50.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 07:17:05 +0000
Received: from EX19D043EUB003.ant.amazon.com (10.252.61.69) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 07:17:04 +0000
Received: from EX19D043EUB003.ant.amazon.com ([fe80::ae8f:9ad3:ae84:18c5]) by
 EX19D043EUB003.ant.amazon.com ([fe80::ae8f:9ad3:ae84:18c5%3]) with mapi id
 15.02.1118.030; Tue, 1 Aug 2023 07:17:04 +0000
From:   "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Yadav, Pratyush" <ptyadav@amazon.de>
Subject: Backport request
Thread-Topic: Backport request
Thread-Index: AQHZxEgsJ2+t6ECt5Um/IpoI2QAhsw==
Date:   Tue, 1 Aug 2023 07:17:04 +0000
Message-ID: <88AC5AF1-276D-42AD-AD41-37FE9A874616@amazon.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2537AF24E156B24F942F4AA6C5B130AD@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGksDQoNClBsZWFzZSBiYWNrcG9ydCBjb21taXRzOg0KDQpjMDJkNWZlYjZlMmYgKCJBQ1BJOiBw
cm9jZXNzb3I6IHBlcmZsaWI6IFVzZSB0aGUgIm5vIGxpbWl0IiBmcmVxdWVuY3kgUW9TIikNCjk5
Mzg3YjAxNjAyMiAoIkFDUEk6IHByb2Nlc3NvcjogcGVyZmxpYjogQXZvaWQgdXBkYXRpbmcgZnJl
cXVlbmN5IFFvUyB1bm5lY2Vzc2FyaWx5IikNCmU4YTBlMzBiNzQyZiAoImNwdWZyZXE6IGludGVs
X3BzdGF0ZTogRHJvcCBBQ1BJIF9QU1Mgc3RhdGVzIHRhYmxlIHBhdGNoaW5nIikNCg0KVG8gc3Rh
YmxlIHRyZWVzIDUuNC55LCA1LjEwLnksIDUuMTUueSwgNi4xLnkuIFRoZXNlIGNvbW1pdHMgZml4
IEludGVsIFR1cmJvIGVuYWJsaW5nIHdoZW4NCmJyaW5naW5nIENQVXMgb2ZmbGluZSBhbmQgb25s
aW5lIGFnYWluLiBJJ3ZlIHRlc3RlZCB0aGlzIG9uIHRoZSBtZW50aW9uZWQgc3RhYmxlIHRyZWVz
Lg0KRmVlbCBmcmVlIHRvIGFkZA0KDQpUZXN0ZWQtYnk6IEhhZ2FyIEhlbWRhbiA8aGFnYXJoZW1A
YW1hem9uLmRlPg0KDQpUaGFua3MsDQpIYWdhcg0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

