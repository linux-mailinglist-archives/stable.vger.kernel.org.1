Return-Path: <stable+bounces-129682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552DA8009A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1407A8D69
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DC26A1C2;
	Tue,  8 Apr 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpQdk4hl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5326A1BC;
	Tue,  8 Apr 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111697; cv=none; b=itpq96euQuGllplgmLMcKfUl6Ssd/JIpGwlAjGUJSezy1qtloPVa+8ho5nJyOkLERtmxouPdFZNYTtEBPhbEpgdtORpKRBaxztSpy8SW+KnbSNxrPlTeyUtqEcJxG5MbNRhde4sQCsWCOOu94hkLkJPiuBpaivEwdjmVylDptHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111697; c=relaxed/simple;
	bh=bjz+uSPU+5UAanYikC6dlMRN9mkFI6biMtDpRxDDzxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUjhvJihCX84D2gfljGp08+aq9VE5UxvVlQjP83YPAER2LmEpKY+pt/XTw81zWvAwpkL8I8PDQJt7aWaHF+iiawg7zAreTt5zkWzIZc7cxufgKr+n0zrwZklqiuRcGMlLm+cQX9QPOYbAeR3saiFFggAXSGG9LQoytTL4lI6y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpQdk4hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F9FC4CEE5;
	Tue,  8 Apr 2025 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111697;
	bh=bjz+uSPU+5UAanYikC6dlMRN9mkFI6biMtDpRxDDzxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpQdk4hlB43C3zNohUJyCZiC73KoXChWQHXkC7hrarwru83uMXeQxEi9MdsJQ75l9
	 lLZRGy6fkkreKXn7CrJQ/3ToM7ycOdtu/RuVSHKoQfhbUyawmVvSc089tGXDSWFg9P
	 Z/87X7fZz6+ESiJE7taP/ZlT5MaRKAP4P6RFBj88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benno Lossin <benno.lossin@proton.me>,
	Danilo Krummrich <dakr@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 509/731] rust: pci: fix unrestricted &mut pci::Device
Date: Tue,  8 Apr 2025 12:46:46 +0200
Message-ID: <20250408104926.115635176@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit 7b948a2af6b5d64a25c14da8f63d8084ea527cd9 ]

As by now, pci::Device is implemented as:

	#[derive(Clone)]
	pub struct Device(ARef<device::Device>);

This may be convenient, but has the implication that drivers can call
device methods that require a mutable reference concurrently at any
point of time.

Instead define pci::Device as

	pub struct Device<Ctx: DeviceContext = Normal>(
		Opaque<bindings::pci_dev>,
		PhantomData<Ctx>,
	);

and manually implement the AlwaysRefCounted trait.

With this we can implement methods that should only be called from
bus callbacks (such as probe()) for pci::Device<Core>. Consequently, we
make this type accessible in bus callbacks only.

Arbitrary references taken by the driver are still of type
ARef<pci::Device> and hence don't provide access to methods that are
reserved for bus callbacks.

Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250314160932.100165-4-dakr@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/pci.rs              | 132 ++++++++++++++++++++------------
 samples/rust/rust_driver_pci.rs |   8 +-
 2 files changed, 89 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 386484dcf36eb..0ac6cef74f815 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     alloc::flags::*,
-    bindings, container_of, device,
+    bindings, device,
     device_id::RawDeviceId,
     devres::Devres,
     driver,
@@ -17,7 +17,11 @@ use crate::{
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{ops::Deref, ptr::addr_of_mut};
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::{addr_of_mut, NonNull},
+};
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -60,17 +64,16 @@ impl<T: Driver + 'static> Adapter<T> {
     ) -> kernel::ffi::c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
-        // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
-        // above.
-        let mut pdev = unsafe { Device::from_dev(dev) };
+        //
+        // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
         let info = T::ID_TABLE.info(id.index());
 
-        match T::probe(&mut pdev, info) {
+        match T::probe(pdev, info) {
             Ok(data) => {
                 // Let the `struct pci_dev` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
@@ -192,7 +195,7 @@ macro_rules! pci_device_table {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, pci};
+/// # use kernel::{bindings, device::Core, pci};
 ///
 /// struct MyDriver;
 ///
@@ -210,7 +213,7 @@ macro_rules! pci_device_table {
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
-///         _pdev: &mut pci::Device,
+///         _pdev: &pci::Device<Core>,
 ///         _id_info: &Self::IdInfo,
 ///     ) -> Result<Pin<KBox<Self>>> {
 ///         Err(ENODEV)
@@ -234,20 +237,23 @@ pub trait Driver {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
-    fn probe(dev: &mut Device, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
 }
 
 /// The PCI device representation.
 ///
-/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
-/// device, hence, also increments the base device' reference count.
+/// This structure represents the Rust abstraction for a C `struct pci_dev`. The implementation
+/// abstracts the usage of an already existing C `struct pci_dev` within Rust code that we get
+/// passed from the C side.
 ///
 /// # Invariants
 ///
-/// `Device` hold a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
-/// member of a `struct pci_dev`.
-#[derive(Clone)]
-pub struct Device(ARef<device::Device>);
+/// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::pci_dev>,
+    PhantomData<Ctx>,
+);
 
 /// A PCI BAR to perform I/O-Operations on.
 ///
@@ -256,13 +262,13 @@ pub struct Device(ARef<device::Device>);
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI bar and its size.
 pub struct Bar<const SIZE: usize = 0> {
-    pdev: Device,
+    pdev: ARef<Device>,
     io: IoRaw<SIZE>,
     num: i32,
 }
 
 impl<const SIZE: usize> Bar<SIZE> {
-    fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
+    fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -300,12 +306,16 @@ impl<const SIZE: usize> Bar<SIZE> {
                 // `pdev` is valid by the invariants of `Device`.
                 // `ioptr` is guaranteed to be the start of a valid I/O mapped memory region.
                 // `num` is checked for validity by a previous call to `Device::resource_len`.
-                unsafe { Self::do_release(&pdev, ioptr, num) };
+                unsafe { Self::do_release(pdev, ioptr, num) };
                 return Err(err);
             }
         };
 
-        Ok(Bar { pdev, io, num })
+        Ok(Bar {
+            pdev: pdev.into(),
+            io,
+            num,
+        })
     }
 
     /// # Safety
@@ -351,20 +361,8 @@ impl<const SIZE: usize> Deref for Bar<SIZE> {
 }
 
 impl Device {
-    /// Create a PCI Device instance from an existing `device::Device`.
-    ///
-    /// # Safety
-    ///
-    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
-    /// a `bindings::pci_dev`.
-    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
-        Self(dev)
-    }
-
     fn as_raw(&self) -> *mut bindings::pci_dev {
-        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
-        // embedded in `struct pci_dev`.
-        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+        self.0.get()
     }
 
     /// Returns the PCI vendor ID.
@@ -379,18 +377,6 @@ impl Device {
         unsafe { (*self.as_raw()).device }
     }
 
-    /// Enable memory resources for this device.
-    pub fn enable_device_mem(&self) -> Result {
-        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
-    }
-
-    /// Enable bus-mastering for this device.
-    pub fn set_master(&self) {
-        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        unsafe { bindings::pci_set_master(self.as_raw()) };
-    }
-
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
@@ -410,7 +396,7 @@ impl Device {
         bar: u32,
         name: &CStr,
     ) -> Result<Devres<Bar<SIZE>>> {
-        let bar = Bar::<SIZE>::new(self.clone(), bar, name)?;
+        let bar = Bar::<SIZE>::new(self, bar, name)?;
         let devres = Devres::new(self.as_ref(), bar, GFP_KERNEL)?;
 
         Ok(devres)
@@ -422,8 +408,60 @@ impl Device {
     }
 }
 
+impl Device<device::Core> {
+    /// Enable memory resources for this device.
+    pub fn enable_device_mem(&self) -> Result {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+    }
+
+    /// Enable bus-mastering for this device.
+    pub fn set_master(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_set_master(self.as_raw()) };
+    }
+}
+
+impl Deref for Device<device::Core> {
+    type Target = Device;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Self = self;
+
+        // CAST: `Device<Ctx>` is a transparent wrapper of `Opaque<bindings::pci_dev>`.
+        let ptr = ptr.cast::<Device>();
+
+        // SAFETY: `ptr` was derived from `&self`.
+        unsafe { &*ptr }
+    }
+}
+
+impl From<&Device<device::Core>> for ARef<Device> {
+    fn from(dev: &Device<device::Core>) -> Self {
+        (&**dev).into()
+    }
+}
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::pci_dev_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::pci_dev_put(obj.cast().as_ptr()) }
+    }
+}
+
 impl AsRef<device::Device> for Device {
     fn as_ref(&self) -> &device::Device {
-        &self.0
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct pci_dev`.
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::as_ref(dev) }
     }
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f33951..4f14e63f323e9 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
+use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -26,7 +26,7 @@ impl TestIndex {
 }
 
 struct SampleDriver {
-    pdev: pci::Device,
+    pdev: ARef<pci::Device>,
     bar: Devres<Bar0>,
 }
 
@@ -62,7 +62,7 @@ impl pci::Driver for SampleDriver {
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(
             pdev.as_ref(),
             "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
@@ -77,7 +77,7 @@ impl pci::Driver for SampleDriver {
 
         let drvdata = KBox::new(
             Self {
-                pdev: pdev.clone(),
+                pdev: pdev.into(),
                 bar,
             },
             GFP_KERNEL,
-- 
2.39.5




